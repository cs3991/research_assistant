import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:research_assistant/collection/view/collection.dart';
import 'package:research_assistant/layout/navigation.dart';
import 'package:research_assistant/newsfeed/view/newsfeed.dart';

import '../../helpers/helpers.dart';

class MockNavigationCubit extends MockCubit<int> implements NavigationCubit {}

void main() {
  group('NavigationPage', () {
    testWidgets('renders NavigationBar', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(const NavigationPage());
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('renders NavigationRail', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1000, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(const NavigationPage());
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('renders Collection when selected (rail)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(const NavigationPage());
      await tester.tap(find.byIcon(Icons.library_books_rounded));
      await tester.pump();
      expect(find.byType(Collection), findsOneWidget);
    });

    testWidgets('renders Collection when selected (bar)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(400, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(const NavigationPage());
      await tester.tap(find.byIcon(Icons.library_books_rounded));
      await tester.pump();
      expect(find.byType(Collection), findsOneWidget);
    });

    testWidgets('renders NewsFeed when selected (rail)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(const NavigationPage());
      await tester.tap(find.byIcon(Icons.rss_feed_rounded));
      await tester.pump();
      expect(find.byType(NewsFeed), findsOneWidget);
    });

    testWidgets('renders NewsFeed when selected (bar)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(400, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpApp(const NavigationPage());
      await tester.tap(find.byIcon(Icons.rss_feed_rounded));
      await tester.pump();
      expect(find.byType(NewsFeed), findsOneWidget);
    });
  });
}
