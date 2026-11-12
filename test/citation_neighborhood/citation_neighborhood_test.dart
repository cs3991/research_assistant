import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_alex_api/open_alex_api.dart' show OpenAlexApiClient;
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/citation_neighborhood/citation_neighborhood_cubit.dart';
import 'package:research_assistant/citation_neighborhood/citation_neighborhood_page.dart';
import 'package:research_assistant/collection/model/citation_layout.dart';
import 'package:research_assistant/collection/model/citation_network.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/publication_details/view/publication_details.dart';

class _Client extends Mock implements OpenAlexApiClient {}

class _Repository extends Mock implements CatalogRepository {}

void main() {
  late _Client client;
  late CatalogRepository decoder;
  setUp(() {
    client = _Client();
    decoder = CatalogRepository(openAlex: client);
  });

  test(
    'loads incoming and outgoing citations and preserves their direction',
    () async {
      final work = decoder.workFromJson({
        'id': 'https://openalex.org/W1',
        'referenced_works': ['https://openalex.org/W2'],
      });
      when(
        () =>
            client.getFilteredWorksData('cites:W1', page: 1, itemsPerPage: 50),
      ).thenAnswer(
        (_) async => {
          'meta': {'count': 1},
          'results': [
            {
              'id': 'W3',
              'referenced_works': ['W1'],
            },
          ],
        },
      );
      when(
        () => client.getFilteredWorksData('openalex:W2', itemsPerPage: 50),
      ).thenAnswer(
        (_) async => {
          'results': [
            {'id': 'W2'},
          ],
        },
      );
      final result = await decoder.getCitationNeighborhood(work);
      final network = CitationNetwork([work, ...result.works]);
      expect(network.nodes, hasLength(3));
      expect(
        network.links.map(
          (link) =>
              '${network.nodes[link.source].id}->${network.nodes[link.target].id}',
        ),
        containsAll([
          'https://openalex.org/W1->W2',
          'W3->https://openalex.org/W1',
        ]),
      );
      expect(result.hasMore, isFalse);
      expect(result.works.every((article) => article.isSummary), isTrue);
      final layout = CitationLayout(network, focusWork: work);
      expect(layout.points.first, layout.size.center(Offset.zero));
    },
  );

  test(
    'failed pages can retry without losing already loaded articles',
    () async {
      final work = decoder.workFromJson({'id': 'W1'});
      final other = decoder.workFromJson({'id': 'W2'});
      final repository = _Repository();
      when(() => repository.getCitationNeighborhood(work, page: 1)).thenAnswer(
        (_) async => CitationNeighborhood(works: [other], hasMore: true),
      );
      when(
        () => repository.getCitationNeighborhood(work, page: 2),
      ).thenThrow(Exception('offline'));
      final cubit = CitationNeighborhoodCubit(
        work: work,
        repository: repository,
      );
      addTearDown(cubit.close);
      await cubit.loadMore();
      await cubit.loadMore();
      expect(cubit.state.works, [work, other]);
      expect(cubit.state.error, isNotNull);
      when(() => repository.getCitationNeighborhood(work, page: 2)).thenAnswer(
        (_) async => const CitationNeighborhood(works: [], hasMore: false),
      );
      await cubit.loadMore();
      expect(cubit.state.hasMore, isFalse);
      expect(cubit.state.error, isNull);
    },
  );

  test(
    'graph summaries fetch full details only on demand and reuse them',
    () async {
      final root = decoder.workFromJson({'id': 'W1'});
      final summary = decoder.workFromJson({'id': 'W2'}, summary: true);
      final full = decoder.workFromJson({'id': 'W2', 'title': 'Full article'});
      final repository = _Repository();
      when(() => repository.getWork('W2')).thenAnswer((_) async => full);
      final cubit = CitationNeighborhoodCubit(
        work: root,
        repository: repository,
      );
      addTearDown(cubit.close);
      verifyNever(() => repository.getWork('W2'));
      expect(await cubit.getDetails(summary), same(full));
      expect(await cubit.getDetails(summary), same(full));
      verify(() => repository.getWork('W2')).called(1);
      expect(await cubit.getDetails(root), same(root));
    },
  );

  testWidgets(
    'detail citations open a graph page and graph nodes open details',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final work = decoder.workFromJson({
        'id': 'W1',
        'title': 'Central article',
        'cited_by_count': 10,
      });
      final repository = _Repository();
      when(() => repository.getCitationNeighborhood(work, page: 1)).thenAnswer(
        (_) async => const CitationNeighborhood(works: [], hasMore: false),
      );
      final navigation = PageStackCubit(page: SearchPage(index: 0))
        ..showPublication(fromIndex: 0, work: work);
      addTearDown(navigation.close);
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              RepositoryProvider<CatalogRepository>.value(value: repository),
              BlocProvider.value(value: navigation),
              BlocProvider(
                create: (_) => PhoneScreenCubit()..constraintChanged(1200),
              ),
            ],
            child: Scaffold(body: PublicationDetails(index: 1, work: work)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cité 10 fois'));
      await tester.pumpAndSettle();
      expect(navigation.state.stack.last, isA<CitationNetworkPage>());
      expect(navigation.state.stack.whereType<SearchPage>(), hasLength(1));
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              RepositoryProvider<CatalogRepository>.value(value: repository),
              BlocProvider.value(value: navigation),
              BlocProvider(
                create: (_) => PhoneScreenCubit()..constraintChanged(1200),
              ),
            ],
            child: Scaffold(
              body: CitationNeighborhoodPage(work: work, index: 2),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey(work)));
      await tester.pumpAndSettle();
      expect(navigation.state.stack, hasLength(4));
      expect(
        (navigation.state.stack.last as PublicationDetailsPage).work,
        same(work),
      );
      expect(navigation.state.stack[2], isA<CitationNetworkPage>());
      expect(tester.takeException(), isNull);
    },
  );
}
