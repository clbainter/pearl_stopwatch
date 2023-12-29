import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/app_module.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/stopwatch_bloc.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/layouts/stopwatch_mobile_landscape.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';

void main() {
  group('StopwatchMobileLandscape Tests', () {
    tearDown(() {
      FakeAsync().flushMicrotasks();
    });
    testWidgets('StopwatchMobileLandscape', (widgetTester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await widgetTester.binding.setSurfaceSize(const Size(2000, 2000));
      const key = Key('theKey');

      final widget = ModularApp(
        module: AppModule(),
        child: const MaterialApp(
          home: Scaffold(
            body: StopwatchMobileLandscape(
              key: key,
            ),
          ),
        ),
      );
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      final bloc = Modular.get<StopwatchBloc>();

      // Check neutral states of elements
      expect(find.byKey(key), findsOneWidget);
      expect(
        find.text(
          bloc.formatTime(
            0,
          ),
        ),
        findsOneWidget,
      );
      expect(find.text(StopwatchStrings.appBarLabel), findsOneWidget);
      expect(find.text(StopwatchStrings.resetButtonText), findsOneWidget);
      expect(find.text(StopwatchStrings.startButtonText), findsOneWidget);
      expect(find.text('Lap 1'), findsNothing);

      //Tap start button

      await widgetTester.tap(find.text(StopwatchStrings.startButtonText));
      await widgetTester.pumpAndSettle();
      expect(find.text(StopwatchStrings.startButtonText), findsNothing);
      expect(find.text(StopwatchStrings.stopButtonText), findsOneWidget);
      expect(find.text(StopwatchStrings.lapButtonText), findsOneWidget);
      expect(find.text(StopwatchStrings.resetButtonText), findsNothing);

      // Tap lap button
      await widgetTester.tap(find.text(StopwatchStrings.lapButtonText));
      await widgetTester.pumpAndSettle();

      // Tap Stop button
      await widgetTester.tap(find.text(StopwatchStrings.stopButtonText));
      await widgetTester.pumpAndSettle();
      expect(find.text(StopwatchStrings.startButtonText), findsOneWidget);
      expect(find.text(StopwatchStrings.stopButtonText), findsNothing);
      expect(find.text(StopwatchStrings.lapButtonText), findsNothing);
      expect(find.text(StopwatchStrings.resetButtonText), findsOneWidget);

      // Check new state of elements
      expectLater(find.byType(Text), findsNWidgets(8));
      expect(
        find.text(
          bloc.formatTime(
            bloc.getLastLapTotalTime(),
          ),
        ),
        findsOneWidget,
      );

      // Tap Reset Button
      await widgetTester.tap(find.text(StopwatchStrings.resetButtonText));
      await widgetTester.pumpAndSettle();
      expect(
        find.text(
          bloc.formatTime(
            0,
          ),
        ),
        findsOneWidget,
      );
      expectLater(find.byType(Text), findsNWidgets(4));
    });
  });
}
