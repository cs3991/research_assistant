import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_alex_api/open_alex_api.dart';
import 'package:research_assistant/catalog_repository/catalog_repository.dart';

class MockOpenAlex extends Mock implements OpenAlexApiClient {}

void main() {
  late MockOpenAlex client;
  late CatalogRepository repository;
  setUp(() {
    client = MockOpenAlex();
    repository = CatalogRepository(openAlex: client);
  });

  test(
    'metadata-poor search and detail do not invent numbers or booleans',
    () async {
      final minimal = <String, dynamic>{
        'id': 'https://openalex.org/W1',
        'title': null,
        'primary_location': {'source': null},
        'open_access': {'is_oa': null},
        'counts_by_year': null,
      };
      when(
        () => client.searchWorksData('minimal', page: 1, itemsPerPage: 25),
      ).thenAnswer((_) async => [minimal]);
      when(() => client.getWorkData('W1')).thenAnswer((_) async => minimal);
      final search = await repository.searchWork('minimal', itemsPerPage: 25);
      final detail = await repository.getWork('W1');
      for (final work in [search.single, detail]) {
        expect(work.title, 'Sans titre');
        expect(work.authors, isEmpty);
        expect(work.abstract, isEmpty);
        expect(work.publicationDate, isNull);
        expect(work.publicationYear, isNull);
        expect(work.citedByCount, isNull);
        expect(work.isOpenAccess, isNull);
        expect(work.doiUrl, isNull);
        expect(work.bestOaUrl, isNull);
        expect(work.conceptsNames, isEmpty);
        expect(work.citationsCountByYear, isEmpty);
      }
    },
  );

  test(
    'unresolved nested objects fall back to raw names and legacy concepts',
    () {
      final work = repository.workFromJson({
        'title': '   ',
        'display_name': 'Known title',
        'authorships': [
          {'author': null, 'raw_author_name': 'Raw name'},
          {
            'author': {'id': null, 'display_name': null},
          },
        ],
        'topics': [
          {'display_name': null},
        ],
        'concepts': [
          {'display_name': 'Legacy concept'},
        ],
        'primary_location': {'source': null},
      });
      expect(work.title, 'Known title');
      expect(work.authors, ['Raw name', 'Auteur inconnu']);
      expect(work.conceptsNames, ['Legacy concept']);
      expect(work.primaryLocation, isEmpty);
    },
  );

  test('unused metadata is never decoded, even if its shape changes', () {
    final work = repository.workFromJson({
      'title': 'Known title',
      'apc_list': {'currency': null, 'value': 'unknown'},
      'funders': 'new shape',
      'locations': [
        {
          'source': {'type': 'new source type'},
        },
      ],
      'authorships': [
        {
          'author': {'display_name': 'Author'},
          'institutions': 'new shape',
          'author_position': 'new value',
        },
      ],
    });
    expect(work.authors, ['Author']);
    expect(work.title, 'Known title');
  });

  test(
    'unknown URLs and dates stay absent, known zero/false are preserved',
    () {
      final work = repository.workFromJson({
        'publication_date': 'not a date',
        'cited_by_count': 0,
        'open_access': {'is_oa': false, 'oa_url': 'https://example.org/open'},
        'best_oa_location': {'pdf_url': '', 'landing_page_url': 'not a URL'},
        'doi': '',
        'counts_by_year': [
          {'cited_by_count': null},
          {'cited_by_count': 0},
        ],
      });
      expect(work.publicationDate, isNull);
      expect(work.citedByCount, 0);
      expect(work.isOpenAccess, isFalse);
      expect(work.doiUrl, isNull);
      expect(work.bestOaUrl.toString(), 'https://example.org/open');
      expect(work.citationsCountByYear, [0]);
    },
  );
}
