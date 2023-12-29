import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/app_module.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/widgets/stopwatch_timer.dart';

void main() {
  group('StopwatchTimer Tests', () {
    tearDown(() {
      FakeAsync().flushMicrotasks();
    });
    testWidgets('StopwatchTimer', (widgetTester) async {
      await widgetTester.binding.setSurfaceSize(const Size(2000, 2000));
      const key = Key('theKey');
      final widget = ModularApp(
        module: AppModule(),
        child: const MaterialApp(
          home: Scaffold(
            body: StopwatchTimer(
              key: key,
            ),
          ),
        ),
      );
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      final bloc = Modular.get<StopwatchBloc>();
      expect(find.byKey(key), findsOneWidget);
      expect(
        find.text(
          bloc.formatTime(
            0,
          ),
        ),
        findsOneWidget,
      );

      bloc.eventBus.fire(StartEvent());
      await widgetTester.pumpAndSettle();
      bloc.eventBus.fire(StopEvent());
      await widgetTester.pumpAndSettle();
      expectLater(find.byType(Text), findsOneWidget);
      expect(
        find.text(
          bloc.formatTime(
            bloc.getLastLapTotalTime(),
          ),
        ),
        findsOneWidget,
      );
      bloc.eventBus.fire(ResetEvent());
      await widgetTester.pumpAndSettle();
      expect(
        find.text(
          bloc.formatTime(
            0,
          ),
        ),
        findsOneWidget,
      );
    });
  });
}
