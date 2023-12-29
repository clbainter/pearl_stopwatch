import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pearl_stopwatch/reusable_components/buttons/circle_button.dart';

class ButtonAction {
  void onPressed() {}
}

class MockAction extends Mock implements ButtonAction {}

void main() {
  group('CircleButton Tests', () {
    testWidgets('CircleButton', (widgetTester) async {
      final mockAction = MockAction();
      final widget = MaterialApp(
        home: CircleButton(
          onPressed: mockAction.onPressed,
          text: 'Button',
        ),
      );
      await widgetTester.pumpWidget(widget);

      expect(find.text('Button'), findsOneWidget);

      await widgetTester.tap(find.text('Button'));
      await widgetTester.pumpAndSettle();
      verify(mockAction.onPressed()).called(1);
    });
  });
}
