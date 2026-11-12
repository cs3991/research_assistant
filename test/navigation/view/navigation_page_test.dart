import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:research_assistant/collection/view/collection.dart';
import 'package:research_assistant/collection/view/library_sidebar.dart';
import 'package:research_assistant/layout/navigation.dart';
import 'package:research_assistant/newsfeed/view/newsfeed.dart';

import '../../helpers/helpers.dart';

void main() {
  for (final width in [400.0, 1000.0]) {
    testWidgets(
      'switches sections on ${width < 650 ? 'phone' : 'desktop'} layout',
      (tester) async {
        tester.view.physicalSize = Size(width, 1100);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpApp(const NavigationPage());
        expect(
          find.byType(width < 650 ? NavigationBar : LibrarySidebar),
          findsOneWidget,
        );
        await tester.tap(find.byIcon(Icons.library_books_rounded));
        await tester.pump();
        expect(find.byType(Collection), findsOneWidget);
        await tester.tap(find.byIcon(Icons.rss_feed_rounded));
        await tester.pump();
        expect(find.byType(NewsFeed), findsOneWidget);
      },
    );
  }
}
