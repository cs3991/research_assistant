import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
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
}
