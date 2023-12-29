import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/app_module.dart';
import 'package:pearl_stopwatch/arch/app_colors.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/model/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/widgets/lap_table.dart';

void main() {
  group('LapTable Tests', () {
    tearDown(() {
      FakeAsync().flushMicrotasks();
    });
    testWidgets('LapTable', (widgetTester) async {
      await widgetTester.binding.setSurfaceSize(const Size(2000, 2000));
      const key = Key('theKey');
      final widget = ModularApp(
        module: AppModule(),
        child: const MaterialApp(
          home: Scaffold(
            body: LapTable(
              key: key,
            ),
          ),
        ),
      );
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      final bloc = Modular.get<StopwatchBloc>();
      expect(find.byKey(key), findsOneWidget);
      expect(find.text('Lap 1'), findsNothing);

      bloc.eventBus.fire(StartEvent());
      await widgetTester.pumpAndSettle();
      bloc.eventBus.fire(LapEvent());
      await widgetTester.pumpAndSettle();
      bloc.eventBus.fire(StopEvent());
      await widgetTester.pumpAndSettle();
      expectLater(find.byType(Text), findsNWidgets(4));
      expect(find.text('Lap 1'), findsOneWidget);
      expect(find.text('Lap 2'), findsOneWidget);
    });

    test('getTextColor() returns proper color', () async {
      const LapTable lapTable = LapTable();
      var color = lapTable.getTextColor(LapPlace.fastest);
      expect(color, AppColors.success);
      color = lapTable.getTextColor(LapPlace.neutral);
      expect(color, AppColors.text);
      color = lapTable.getTextColor(LapPlace.slowest);
      expect(color, AppColors.error);
    });
  });
}
