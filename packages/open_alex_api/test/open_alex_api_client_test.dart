import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'models/json_response.dart';

Map<String, dynamic> fixture(String name) =>
    jsonDecode(File('test/fixtures/${name}_current.json').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  late OpenAlexApiClient client;
  tearDown(() => client.close());

  test(
    'search uses current parameters, encodes query and sends API key',
    () async {
      client = OpenAlexApiClient(
        apiKey: 'test-key',
        httpClient: MockClient((request) async {
          expect(request.url.path, '/works');
          expect(request.url.queryParameters, {
            'search': 'climate & health',
            'page': '2',
            'per_page': '25',
          });
          expect(request.headers['Authorization'], 'Bearer test-key');
          expect(request.url.toString(), isNot(contains('test-key')));
          return http.Response(
            jsonEncode(fixture('works')),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );
      final works = await client.searchWorks(
        'climate & health',
        page: 2,
        itemsPerPage: 25,
      );
      expect(works, hasLength(2));
      expect(works.first.topics, isNotEmpty);
      expect(works.first.grants, isEmpty);
      expect(works.first.ngramsUrl, isEmpty);
    },
  );

  test(
    'supports unauthenticated requests without a misleading polite pool',
    () async {
      client = OpenAlexApiClient(
        apiKey: '',
        httpClient: MockClient((request) async {
          expect(request.headers.containsKey('Authorization'), isFalse);
          return http.Response('{"results":[]}', 200);
        }),
      );
      expect(
        await client.searchWorks('unmatched', page: 1, itemsPerPage: 100),
        isEmpty,
      );
    },
  );

  test(
    'accepts short and full work IDs and decodes current responses',
    () async {
      client = OpenAlexApiClient(
        httpClient: MockClient((request) async {
          expect(request.url.path, '/works/W4232533539');
          return http.Response(
            jsonEncode(fixture('works')['results'][0]),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );
      for (final id in ['W4232533539', 'https://openalex.org/W4232533539']) {
        final work = await client.getWork(id);
        expect(work.title, 'Machine Learning');
        expect(work.authorships.first.rawAffiliationString, isNotEmpty);
      }
    },
  );

  test('continues to decode legacy work responses', () async {
    client = OpenAlexApiClient(
      httpClient: MockClient(
        (_) async => http.Response(
          workJsonResponse,
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      ),
    );
    final work = await client.getWork('W2741809807');
    expect(
      work.title,
      'The state of OA: a large-scale analysis of the prevalence and impact of Open Access articles',
    );
    expect(work.concepts, isNotEmpty);
    expect(work.topics, isEmpty);
  });

  test(
    'source endpoint decodes APC arrays and summary statistics object',
    () async {
      client = OpenAlexApiClient(
        httpClient: MockClient((request) async {
          expect(request.url.path, '/sources/S137519996');
          return http.Response(
            jsonEncode(fixture('source')),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          );
        }),
      );
      final source = await client.getSource('https://openalex.org/S137519996');
      expect(source.displayName, 'Electronic Markets');
      expect(source.apcPrices, isA<List<SourceApcPrice>>());
      expect(source.summaryStats!.hIndex, greaterThan(0));
      expect(source.apcPrices.first.price, greaterThan(0));
      // Keep existing callers working while they migrate to getSource.
      // ignore: deprecated_member_use_from_same_package
      expect((await client.getVenue('S137519996')).id, source.id);
    },
  );

  test('author endpoint decodes plural current affiliations', () async {
    client = OpenAlexApiClient(
      httpClient: MockClient((request) async {
        expect(request.url.path, '/authors/A5100621138');
        return http.Response(
          jsonEncode(fixture('author')),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      }),
    );
    final author = await client.getAuthor('https://openalex.org/A5100621138');
    expect(author.lastKnownInstitutions, isNotEmpty);
    expect(author.lastKnownInstitution, isNull);
  });

  test('institution endpoint decodes current payload', () async {
    client = OpenAlexApiClient(
      httpClient: MockClient((request) async {
        expect(request.url.path, '/institutions/I881766915');
        return http.Response(
          jsonEncode(fixture('institution')),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      }),
    );
    expect(
      (await client.getInstitution(
        'https://openalex.org/I881766915',
      )).displayName,
      'Nanjing University',
    );
  });

  test('topic endpoint decodes hierarchy', () async {
    client = OpenAlexApiClient(
      httpClient: MockClient((request) async {
        expect(request.url.path, '/topics/T10001');
        return http.Response(
          jsonEncode(fixture('topic')),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      }),
    );
    final topic = await client.getTopic('https://openalex.org/T10001');
    expect(topic.domain!.displayName, isNotEmpty);
    expect(topic.description, isNotEmpty);
  });

  test('legacy concepts endpoint remains available', () async {
    client = OpenAlexApiClient(
      httpClient: MockClient((request) async {
        expect(request.url.path, '/concepts/C2778407487');
        return http.Response(conceptJsonResponse, 200);
      }),
    );
    expect(
      (await client.getConcept('https://openalex.org/C2778407487')).id,
      'https://openalex.org/C2778407487',
    );
  });

  for (final status in [429, 500, 503]) {
    test('retries $status and returns successful search', () async {
      var calls = 0;
      client = OpenAlexApiClient(
        retryDelay: Duration.zero,
        httpClient: MockClient((_) async {
          calls++;
          return calls < 3
              ? http.Response('{}', status)
              : http.Response('{"results":[]}', 200);
        }),
      );
      expect(
        await client.searchWorks('test', page: 1, itemsPerPage: 25),
        isEmpty,
      );
      expect(calls, 3);
    });
  }

  test('stops retrying persistent rate limits', () async {
    var calls = 0;
    client = OpenAlexApiClient(
      retryDelay: Duration.zero,
      httpClient: MockClient((_) async {
        calls++;
        return http.Response('{}', 429);
      }),
    );
    await expectLater(
      client.searchWorks('test', page: 1, itemsPerPage: 25),
      throwsA(isA<WorkRequestFailure>()),
    );
    expect(calls, 3);
  });

  for (final status in [400, 401, 403]) {
    test('does not retry client error $status', () async {
      var calls = 0;
      client = OpenAlexApiClient(
        httpClient: MockClient((_) async {
          calls++;
          return http.Response('{}', status);
        }),
      );
      await expectLater(
        client.getWork('W1'),
        throwsA(isA<WorkRequestFailure>()),
      );
      expect(calls, 1);
    });
  }

  test('preserves endpoint-specific not found errors', () async {
    client = OpenAlexApiClient(
      httpClient: MockClient((_) async => http.Response('{}', 404)),
    );
    await expectLater(
      client.getWork('W1'),
      throwsA(isA<WorkNotFoundFailure>()),
    );
    await expectLater(
      client.getAuthor('A1'),
      throwsA(isA<AuthorNotFoundFailure>()),
    );
    await expectLater(
      client.getSource('S1'),
      throwsA(isA<VenueNotFoundFailure>()),
    );
    await expectLater(
      client.getInstitution('I1'),
      throwsA(isA<InstitutionNotFoundFailure>()),
    );
    await expectLater(
      client.getTopic('T1'),
      throwsA(isA<TopicNotFoundFailure>()),
    );
    await expectLater(
      client.getConcept('C1'),
      throwsA(isA<ConceptNotFoundFailure>()),
    );
  });

  test('validates page size and the basic pagination limit locally', () async {
    client = OpenAlexApiClient(
      httpClient: MockClient((_) async => fail('Unexpected request')),
    );
    for (final page in [0, -1, 401]) {
      await expectLater(
        client.searchWorks('test', page: page, itemsPerPage: 25),
        throwsArgumentError,
      );
    }
    for (final size in [0, -1, 101]) {
      await expectLater(
        client.searchWorks('test', page: 1, itemsPerPage: size),
        throwsArgumentError,
      );
    }
  });
}
