import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:test/test.dart';

import 'models/json_response.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenAlexApiClient', () {
    late http.Client httpClient;
    late OpenAlexApiClient metaWorkApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      metaWorkApiClient = OpenAlexApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenAlexApiClient(), isNotNull);
      });
    });

    group('getWork', () {
      const workId = 'https://openalex.org/W2741809807';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaWorkApiClient.getWork(workId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openalex.org',
              'works/$workId',
            ),
          ),
        ).called(1);
      });

      test('throws WorkRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getWork(workId),
          throwsA(isA<WorkRequestFailure>()),
        );
      });

      test('throws WorkNotFoundFailure on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getWork(workId),
          throwsA(isA<WorkNotFoundFailure>()),
        );
      });

      test('returns work on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(workJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaWorkApiClient.getWork(workId);
        expect(
          actual,
          isA<Work>()
              .having(
                (work) => work.id,
                'openAlexId',
                'https://openalex.org/W2741809807',
              )
              .having(
                (work) => work.title,
                'title',
                'éThe state of OA: a large-scale analysis of the prevalence and impact of Open Access articles',
              )
              .having(
                (work) => work.displayName,
                'displayName',
                'The state of OA: a large-scale analysis of the prevalence and impact of Open Access articles',
              )
              .having(
                (work) => work.publicationDate,
                'publicationDate',
                DateTime(2018, 2, 13),
              )
              .having(
                (work) => work.publicationYear,
                'publicationYear',
                2018,
              )
              .having(
                (work) => work.type,
                'type',
                WorkType.journalArticle,
              )
              .having(
                (work) => work.isOpenAccess,
                'isOpenAccess',
                true,
              )
              .having(
                (work) => work.openAccessStatus,
                'openAccessStatus',
                OpenAccessStatus.gold,
              )
              .having(
                (work) => work.openAccessUrl,
                'openAccessUrl',
                'https://peerj.com/articles/4375.pdf',
              )
              .having(
                (work) => work.citedByCount,
                'citedByCount',
                394,
              )
              .having(
                (work) => work.isRetracted,
                'isRetracted',
                false,
              )
              .having(
                (work) => work.isParatext,
                'isParatext',
                false,
              )
              .having(
                (work) => work.citedByApiUrl,
                'citedByApiUrl',
                'https://api.openalex.org/works?filter=cites:W2741809807',
              )
              .having(
                (work) => work.countsByYear,
                'citedByCountsByYear',
                [
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2022)
                      .having((year) => year.citedByCount, 'citedByCount', 13),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2021)
                      .having((year) => year.citedByCount, 'citedByCount', 108),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2020)
                      .having((year) => year.citedByCount, 'citedByCount', 126),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2019)
                      .having((year) => year.citedByCount, 'citedByCount', 97),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2018)
                      .having((year) => year.citedByCount, 'citedByCount', 47),
                  isA<YearWork>()
                      .having((year) => year.year, 'year', 2017)
                      .having((year) => year.citedByCount, 'citedByCount', 6),
                ],
              )
              .having(
                (work) => work.updatedDate,
                'updatedDate',
                DateTime(2022, 5, 27),
              )
              .having(
                (work) => work.createdDate,
                'createdDate',
                DateTime(2017, 8, 8),
              ),
        );
      });
    });
    group('getAuthor', () {
      const authorId = 'https://openalex.org/A1969205032';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await metaWorkApiClient.getAuthor(authorId);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'api.openalex.org',
              'authors/$authorId',
            ),
          ),
        ).called(1);
      });

      test('throws AuthorRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getAuthor(authorId),
          throwsA(isA<AuthorRequestFailure>()),
        );
      });

      test('throws AuthorNotFoundFailure on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await metaWorkApiClient.getAuthor(authorId),
          throwsA(isA<AuthorNotFoundFailure>()),
        );
      });

      test('returns author on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(authorJsonResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await metaWorkApiClient.getAuthor(authorId);
        expect(
          actual,
          isA<Author>()
              .having(
                (author) => author.id,
                'openAlexId',
                'https://openalex.org/A1969205032',
              )
              .having(
                (author) => author.orcidId,
                'orcid',
                'https://orcid.org/0000-0003-1613-5981',
              )
              .having(
                (author) => author.displayName,
                'displayName',
                'Heather A. Piwowar',
              )
              .having(
                (author) => author.displayNameAlternatives,
                'displayNameAlternatives',
                [],
              )
              .having(
                (author) => author.worksCount,
                'worksCount',
                50,
              )
              .having(
                (author) => author.citedByCount,
                'citedByCount',
                2691,
              )
              .having(
                (author) => author.magId,
                'mag',
                '1969205032',
              )
              .having(
                (author) => author.twitterId,
                'twitter',
                'http://twitter.com/researchremix',
              )
              .having(
                (author) => author.scopusId,
                'scopus',
                'http://www.scopus.com/inward/authorDetails.url?authorID=25122628200&partnerID=MN8TOARS',
              )
              .having(
                (author) => author.worksApiUrl,
                'worksApiUrl',
                'https://api.openalex.org/works?filter=author.id:A1969205032',
              )
              .having(
                (author) => author.updatedDate,
                'updatedDate',
                DateTime(2022, 03, 09),
              )
              .having(
                (author) => author.createdDate,
                'createdDate',
                DateTime(2016, 06, 24),
              )
              .having((author) => author.countsByYear, 'citedByCountsByYear', [
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2022)
                    .having((year) => year.worksCount, 'worksCount', 0)
                    .having((year) => year.citedByCount, 'citedByCount', 52),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2021)
                    .having((year) => year.worksCount, 'worksCount', 1)
                    .having((year) => year.citedByCount, 'citedByCount', 299),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2020)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 367),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2019)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 291),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2018)
                    .having((year) => year.worksCount, 'worksCount', 3)
                    .having((year) => year.citedByCount, 'citedByCount', 265),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2017)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 227),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2016)
                    .having((year) => year.worksCount, 'worksCount', 1)
                    .having((year) => year.citedByCount, 'citedByCount', 230),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2015)
                    .having((year) => year.worksCount, 'worksCount', 0)
                    .having((year) => year.citedByCount, 'citedByCount', 273),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2014)
                    .having((year) => year.worksCount, 'worksCount', 1)
                    .having((year) => year.citedByCount, 'citedByCount', 212),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2013)
                    .having((year) => year.worksCount, 'worksCount', 9)
                    .having((year) => year.citedByCount, 'citedByCount', 223),
                isA<YearAuthor>()
                    .having((year) => year.year, 'year', 2012)
                    .having((year) => year.worksCount, 'worksCount', 2)
                    .having((year) => year.citedByCount, 'citedByCount', 99),
              ]),
        );
      });
    });
  });
}
