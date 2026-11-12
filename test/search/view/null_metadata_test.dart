import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_alex_api/open_alex_api.dart' show OpenAlexApiClient;
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/search/cubit/search_cubit.dart';
import 'package:research_assistant/search/view/search_results.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  testWidgets('search renders a result with unknown year and citation count', (
    tester,
  ) async {
    final client = OpenAlexApiClient();
    addTearDown(client.close);
    final work = CatalogRepository(openAlex: client).workFromJson({});
    final repository = MockCatalogRepository();
    when(
      () => repository.searchWork('test', page: 1, itemsPerPage: 25),
    ).thenAnswer((_) async => [work]);
    final cubit = SearchCubit(catalogRepository: repository);
    addTearDown(cubit.close);
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: cubit),
          BlocProvider(
            create: (_) => PageStackCubit(page: SearchPage(index: 0)),
          ),
        ],
        child: const MaterialApp(
          home: Scaffold(body: Column(children: [SearchResults()])),
        ),
      ),
    );
    await tester.pumpAndSettle();
    cubit.updateQuery(query: 'test');
    await tester.pumpAndSettle();
    expect(find.text('Sans titre'), findsOneWidget);
    expect(find.textContaining('Année inconnue'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
