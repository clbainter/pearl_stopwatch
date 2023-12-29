import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/app_module.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/stopwatch_bloc.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/layouts/stopwatch_laptop_plus.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';

void main() {
  group('StopwatchLaptopPlus Tests', () {
    tearDown(() {
      FakeAsync().flushMicrotasks();
    });
    testWidgets('StopwatchLaptopPlus', (widgetTester) async {
      WidgetsFlutterBinding.ensureInitialized();
      await widgetTester.binding.setSurfaceSize(const Size(2000, 2000));
      const key = Key('theKey');

      final widget = ModularApp(
        module: AppModule(),
        child: const MaterialApp(
          home: Scaffold(
            body: StopwatchLaptopPlus(
              key: key,
            ),
          ),
        ),
      );
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      final bloc = Modular.get<StopwatchBloc>();
      final reset = StopwatchStrings.resetButtonText.toUpperCase();
      final start = StopwatchStrings.startButtonText.toUpperCase();
      final stop = StopwatchStrings.stopButtonText.toUpperCase();
      final lap = StopwatchStrings.lapButtonText.toUpperCase();

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
      expect(find.text(reset), findsOneWidget);
      expect(find.text(start), findsOneWidget);
      expect(find.text('Lap 1'), findsNothing);

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

      // Check new state of elements
      expectLater(find.byType(Text), findsNWidgets(13));
      expect(
        find.text(
          bloc.formatTime(
            bloc.getLastLapTotalTime(),
          ),
        ),
        findsNWidgets(2),
      );

      // Tap Reset Button
      await widgetTester.tap(find.text(reset));
      await widgetTester.pumpAndSettle();
      expect(
        find.text(
          bloc.formatTime(
            0,
          ),
        ),
        findsOneWidget,
      );
      expectLater(find.byType(Text), findsNWidgets(7));
    });
  });
}
