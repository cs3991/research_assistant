import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_alex_api/open_alex_api.dart' show OpenAlexApiClient;
import 'package:research_assistant/catalog_repository/catalog_repository.dart';
import 'package:research_assistant/layout/cubit/page_stack_cubit.dart';
import 'package:research_assistant/layout/cubit/responsive_cubit.dart';
import 'package:research_assistant/publication_details/view/publication_details.dart';

void main() {
  testWidgets(
    'publication displays unknown metadata without claiming zero or closed access',
    (tester) async {
      final client = OpenAlexApiClient();
      addTearDown(client.close);
      final work = CatalogRepository(openAlex: client).workFromJson({});
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => PhoneScreenCubit()),
            BlocProvider(
              create: (_) => PageStackCubit(page: SearchPage(index: 0)),
            ),
          ],
          child: MaterialApp(
            home: Scaffold(body: PublicationDetails(index: 1, work: work)),
          ),
        ),
      );
      expect(find.text('Sans titre'), findsOneWidget);
      expect(find.text('Date de publication inconnue'), findsOneWidget);
      expect(find.text('Citations inconnues'), findsOneWidget);
      expect(find.byIcon(Icons.help_outline_rounded), findsOneWidget);
      expect(find.byIcon(Icons.lock_rounded), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('zero citation history has finite graph heights', (tester) async {
    final client = OpenAlexApiClient();
    addTearDown(client.close);
    final work = CatalogRepository(openAlex: client).workFromJson({
      'counts_by_year': [
        {'cited_by_count': 0},
        {'cited_by_count': null},
      ],
    });
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CountByYearGraph(work: work, maxHeight: 40)),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
