import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_alex_api/open_alex_api.dart' show OpenAlexApiClient;
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/collection/model/citation_network.dart';
import 'package:research_assistant/collection/model/citation_layout.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';

class _Repository extends Mock implements CatalogRepository {}

void main() {
  late OpenAlexApiClient client;
  late CatalogRepository decoder;
  setUp(() {
    client = OpenAlexApiClient();
    decoder = CatalogRepository(openAlex: client);
  });
  tearDown(() => client.close());

  test('decodes references and links only distinct loaded endpoints', () {
    final first = decoder.workFromJson({
      'id': 'https://openalex.org/W1',
      'referenced_works': ['https://openalex.org/W2', 'W2', 'W1', 'W999'],
    });
    final second = decoder.workFromJson({'id': 'https://openalex.org/W2'});
    final missing = decoder.workFromJson({});
    final network = CitationNetwork([first, second, first, missing]);
    expect(first.referencedWorkIds, hasLength(4));
    expect(network.nodes, [first, second, missing]);
    expect(network.links, hasLength(1));
    expect(network.links.single.source, 0);
    expect(network.links.single.target, 1);
  });

  test(
    'pagination retains graph articles and new searches clear them',
    () async {
      final first = decoder.workFromJson({
        'id': 'W1',
        'referenced_works': ['W2'],
      });
      final second = decoder.workFromJson({'id': 'W2'});
      final repository = _Repository();
      when(
        () => repository.searchWork('query', page: 1, itemsPerPage: 1),
      ).thenAnswer((_) async => [first]);
      when(
        () => repository.searchWork('query', page: 2, itemsPerPage: 1),
      ).thenAnswer((_) async => [second]);
      final cubit = SearchCubit(catalogRepository: repository);
      addTearDown(cubit.close);
      await cubit.search(query: 'query', page: 1, itemsPerPage: 1);
      await cubit.search(query: 'query', page: 2, itemsPerPage: 1);
      expect(cubit.state.works, [first, second]);
      expect((cubit.state as SearchResultLoaded).results, [second]);
      expect(CitationNetwork(cubit.state.works).links, hasLength(1));
      cubit.updateQuery(query: 'next');
      expect(cubit.state.works, isEmpty);
    },
  );
  test('layout attracts citations and encodes citation counts as area', () {
    final works = List.generate(
      4,
      (i) => decoder.workFromJson({
        'id': 'W${i + 1}',
        'cited_by_count': i == 0 ? 100 : 400,
        'publication_year': 2020,
        'authorships': [
          {
            'author': {'display_name': 'First Author'},
          },
        ],
        'referenced_works': i == 0 ? ['W2'] : [],
      }),
    );
    final linked = CitationLayout(CitationNetwork(works));
    final unlinked = CitationLayout(
      CitationNetwork(
        works
            .map(
              (work) => decoder.workFromJson({
                'id': work.id,
                'cited_by_count': work.citedByCount,
                'publication_year': work.publicationYear,
              }),
            )
            .toList(),
      ),
    );
    expect(
      (linked.points[0] - linked.points[1]).distance,
      lessThan((unlinked.points[0] - unlinked.points[1]).distance),
    );
    expect(linked.radii[1] / linked.radii[0], closeTo(2, .001));
    expect(CitationLayout.label(works.first), 'First Author, 2020');
    expect(
      CitationLayout.label(decoder.workFromJson({})),
      'Auteur inconnu, s. d.',
    );
  });
  test('year bands keep recent papers above older ones despite citations', () {
    final works = [
      decoder.workFromJson({
        'id': 'W1',
        'publication_year': 1990,
        'referenced_works': ['W3'],
      }),
      decoder.workFromJson({'id': 'W2', 'publication_year': 2020}),
      decoder.workFromJson({
        'id': 'W3',
        'publication_year': 2025,
        'referenced_works': ['W1'],
      }),
      decoder.workFromJson({'id': 'W4'}),
    ];
    final layout = CitationLayout(CitationNetwork(works));
    expect(layout.points[2].dy, lessThan(layout.points[1].dy));
    expect(layout.points[1].dy, lessThan(layout.points[0].dy));
    expect(layout.points[3].dy, greaterThan(layout.points[0].dy));
    expect(
      layout.points.every((point) => point.dx.isFinite && point.dy.isFinite),
      isTrue,
    );
  });
}
