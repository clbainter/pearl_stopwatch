import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/app_module.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/widgets/stopwatch_buttons_sm.dart';

void main() {
  group('StopwatchButtonsSm Tests', () {
    tearDown(() {
      FakeAsync().flushMicrotasks();
    });
    testWidgets('StopwatchButtonsSm', (widgetTester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await widgetTester.binding.setSurfaceSize(const Size(2000, 2000));
      const key = Key('theKey');

      final widget = ModularApp(
        module: AppModule(),
        child: const MaterialApp(
          home: Scaffold(
            body: StopwatchButtonsSm(
              key: key,
            ),
          ),
        ),
      );
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      const reset = StopwatchStrings.resetButtonText;
      const start = StopwatchStrings.startButtonText;
      const stop = StopwatchStrings.stopButtonText;
      const lap = StopwatchStrings.lapButtonText;

      // Check neutral states of elements
      expect(find.byKey(key), findsOneWidget);
      expect(find.text(reset), findsOneWidget);
      expect(find.text(start), findsOneWidget);

      //Tap start button

      await widgetTester.tap(find.text(start));
      await widgetTester.pumpAndSettle();
      expect(find.text(start), findsNothing);
      expect(find.text(stop), findsOneWidget);
      expect(find.text(lap), findsOneWidget);
      expect(find.text(reset), findsNothing);

      // Tap lap button
      await widgetTester.tap(find.text(lap));
      await widgetTester.pumpAndSettle();

      // Tap Stop button
      await widgetTester.tap(find.text(stop));
      await widgetTester.pumpAndSettle();
      expect(find.text(start), findsOneWidget);
      expect(find.text(stop), findsNothing);
      expect(find.text(lap), findsNothing);
      expect(find.text(reset), findsOneWidget);

      // Tap Reset Button
      await widgetTester.tap(find.text(reset));
      await widgetTester.pumpAndSettle();
      expectLater(find.byType(Text), findsNWidgets(2));
    });
  });
}
