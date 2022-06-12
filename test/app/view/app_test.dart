// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:research_assistant/app/app.dart';
import 'package:research_assistant/navigation/navigation.dart';

void main() {
  group('App', () {
    testWidgets('renders NavigationPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(NavigationPage), findsOneWidget);
    });
  });
}
