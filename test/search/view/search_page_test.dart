import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/search/search.dart';
import 'package:mockingjay/mockingjay.dart';

void main() {
  group('SearchPage', () {
    late MockNavigator mockNavigator;

    setUpAll(() {
      mockNavigator = MockNavigator();
    });
    testWidgets('should renders correct page', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockNavigatorProvider(
            navigator: mockNavigator,
            child: SearchPage(),
          ),
        ),
      );

      expect(find.byType(SearchPage), findsOneWidget);
      expect(find.text('City Search'), findsOneWidget);
    });

    testWidgets('should pop when click in search', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MockNavigatorProvider(
            navigator: mockNavigator,
            child: SearchPage(),
          ),
        ),
      );

      await tester.tap(find.byKey(Key('searchPage_search_iconButton')));

      verify(() => mockNavigator.pop("")).called(1);
    });
  });
}
