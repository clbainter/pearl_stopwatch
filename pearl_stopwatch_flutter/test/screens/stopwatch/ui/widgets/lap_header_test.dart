import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/widgets/lap_header.dart';

void main() {
  group('LapHeader Tests', () {
    testWidgets('LapHeader', (widgetTester) async {
      const key = Key('theKey');
      const widget = MaterialApp(
        home: Scaffold(
          body: LapHeader(
            key: key,
          ),
        ),
      );
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.text(StopwatchStrings.lapNumberHeader), findsOneWidget);
      expect(find.text(StopwatchStrings.lapTimeHeader), findsOneWidget);
      expect(find.text(StopwatchStrings.totalTimeHeader), findsOneWidget);
    });
  });
}
