import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_alex_api/open_alex_api.dart' show OpenAlexApiClient;
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/collection/view/citation_graph.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';
import 'package:research_assistant/search/view/search.dart';
import 'package:research_assistant/search/view/search_results.dart';

class _Repository extends Mock implements CatalogRepository {}

void main() {
  testWidgets('graph extends search without replacing the results', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final repository = _Repository();
    when(
      () => repository.searchWork('TMR', page: 1, itemsPerPage: 25),
    ).thenAnswer((_) async => []);
    final search = SearchCubit(catalogRepository: repository);
    addTearDown(search.close);
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: search),
            BlocProvider(
              create: (_) => PhoneScreenCubit()..constraintChanged(1200),
            ),
            BlocProvider(
              create: (_) => PageStackCubit(page: SearchPage(index: 0)),
            ),
          ],
          child: const Scaffold(body: Row(children: [Search()])),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(CitationGraph), findsNothing);
    expect(find.byTooltip('Déployer le graphe de citations'), findsNothing);
    final originalWidth = tester.getSize(find.byType(Search)).width;
    search.updateQuery(query: 'TMR');
    await tester.pumpAndSettle();
    expect(find.byType(CitationGraph), findsNothing);
    final results = tester.state(find.byType(SearchResults));
    await tester.tap(find.byTooltip('Déployer le graphe de citations'));
    await tester.pumpAndSettle();
    expect(find.byType(CitationGraph), findsOneWidget);
    expect(
      tester.getSize(find.byType(Search)).width,
      greaterThan(originalWidth),
    );
    expect(tester.state(find.byType(SearchResults)), same(results));
    await tester.tap(find.byTooltip('Rétracter le graphe de citations'));
    await tester.pumpAndSettle();
    expect(find.byType(CitationGraph), findsNothing);
    expect(tester.getSize(find.byType(Search)).width, originalWidth);
    await tester.tap(find.byTooltip('Déployer le graphe de citations'));
    await tester.pumpAndSettle();
    search.updateQuery(query: '');
    await tester.pumpAndSettle();
    expect(find.byType(CitationGraph), findsNothing);
    expect(tester.getSize(find.byType(Search)).width, originalWidth);
    expect(tester.takeException(), isNull);
  });
  testWidgets('clicking a graph node opens its publication from search', (
    tester,
  ) async {
    final client = OpenAlexApiClient();
    addTearDown(client.close);
    final decoder = CatalogRepository(openAlex: client);
    final first = decoder.workFromJson({
      'id': 'W1',
      'title': 'First paper',
      'cited_by_count': 100,
    });
    final second = decoder.workFromJson({'id': 'W2', 'title': 'Second paper'});
    final repository = _Repository();
    when(
      () => repository.searchWork('query', page: 1, itemsPerPage: 25),
    ).thenAnswer((_) async => [first, second]);
    final search = SearchCubit(catalogRepository: repository);
    final navigation = PageStackCubit(page: SearchPage(index: 0));
    addTearDown(search.close);
    addTearDown(navigation.close);
    await search.search(query: 'query', page: 1, itemsPerPage: 25);
    navigation.showPublication(fromIndex: 0, work: second);
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: search),
            BlocProvider.value(value: navigation),
          ],
          child: Scaffold(body: CitationGraph(onCollapse: () {})),
        ),
      ),
    );
    bool isSelected(Work work) => tester
        .widget<Semantics>(
          find
              .ancestor(
                of: find.byKey(ValueKey(work)),
                matching: find.byType(Semantics),
              )
              .first,
        )
        .properties
        .selected!;
    expect(isSelected(first), isFalse);
    expect(isSelected(second), isTrue);
    await tester.tap(find.byKey(ValueKey(first)));
    await tester.pumpAndSettle();
    expect(isSelected(first), isTrue);
    expect(isSelected(second), isFalse);
    expect(navigation.state.stack, hasLength(2));
    expect(
      (navigation.state.stack.last as PublicationDetailsPage).work,
      same(first),
    );
    navigation.pop(fromIndex: 1);
    await tester.pumpAndSettle();
    expect(isSelected(first), isFalse);
    expect(isSelected(second), isFalse);
    expect(tester.takeException(), isNull);
  });
}
