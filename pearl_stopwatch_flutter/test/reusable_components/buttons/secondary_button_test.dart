import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pearl_stopwatch/reusable_components/buttons/index.dart';

class ButtonAction {
  void onPressed() {}
}

class MockAction extends Mock implements ButtonAction {}

void main() {
  group('SecondaryButton Tests', () {
    testWidgets('SecondaryButton', (widgetTester) async {
      final mockAction = MockAction();
      const key = Key('theKey');
      final widget = MaterialApp(
        home: Scaffold(
          body: SecondaryButton(
            onPressed: mockAction.onPressed,
            text: 'Button',
            key: key,
          ),
        ),
      );
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);

      await widgetTester.tap(find.byKey(key));
      await widgetTester.pumpAndSettle();
      verify(mockAction.onPressed()).called(1);
    });
  });
}
