import 'dart:async';

import 'package:bloc_widget_arch/bloc/base_arch_bloc.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/model/lap.dart';

void main() {
  group('StopwatchBloc Tests', () {
    late StopwatchBloc bloc;
    setUp(() {
      bloc = StopwatchBloc();
    });
    tearDown(() {
      FakeAsync().flushMicrotasks();
    });

    test('registerEvents() registers all events', () async {
      WidgetsFlutterBinding.ensureInitialized();
      expect(bloc.eventListeners.length, 4);
    });

    test('event handlers manage state properly', () async {
      WidgetsFlutterBinding.ensureInitialized();
      // check initial state
      expect(bloc.state.laps.length, 0);
      expect(bloc.state.isStarted, false);
      expect(bloc.state.timeElapsed, 0);
      expect(bloc.state.storedTime, 0);

      // run handleStartEvent
      bloc.handleStartEvent(StartEvent());
      await Future.delayed(const Duration(seconds: 1));
      expect(bloc.state.isStarted, true);
      expect(bloc.state.laps.length, 1);

      // run handleStopEvent
      bloc.handleStopEvent(StopEvent());
      await Future.delayed(const Duration(seconds: 1));
      expect(bloc.state.isStarted, false);
      expect(bloc.state.laps.length, 1);
      expect(bloc.state.timeElapsed, isNot(0));
      expect(bloc.state.storedTime, isNot(0));

      // re-run handleStartEvent
      bloc.handleStartEvent(StartEvent());
      await Future.delayed(const Duration(seconds: 1));
      expect(bloc.state.isStarted, true);
      expect(bloc.state.laps.length, 1);

      // run handleLapEvent
      bloc.handleLapEvent(LapEvent());
      await Future.delayed(const Duration(seconds: 1));
      expect(bloc.state.isStarted, true);

      // re-run handleStopEvent
      bloc.handleStopEvent(StopEvent());
      await Future.delayed(const Duration(seconds: 1));
      expect(bloc.state.isStarted, false);
      expect(bloc.state.laps.length, 2);
      expect(bloc.state.timeElapsed, isNot(0));
      expect(bloc.state.storedTime, isNot(0));

      // run handleResetEvent
      bloc.handleResetEvent(ResetEvent());
      await Future.delayed(const Duration(seconds: 1));
      expect(bloc.state.isStarted, false);
      expect(bloc.state.laps.length, 0);
      expect(bloc.state.timeElapsed, 0);
      expect(bloc.state.storedTime, 0);
    });

    test('formatTime() returns proper String', () async {
      WidgetsFlutterBinding.ensureInitialized();
      String formatted = bloc.formatTime(123456);
      expect(formatted, '02:3.46');
    });

    test('getLastLapTotalTime returns correct value', () async {
      WidgetsFlutterBinding.ensureInitialized();
      int returnValue = bloc.getLastLapTotalTime();
      expect(returnValue, 0);
      bloc.add(
        UpdateEvent(
          bloc.state.copyWith(
            laps: [
              Lap(lapPlace: LapPlace.neutral, lapTime: 123, totalTime: 321),
            ],
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      returnValue = bloc.getLastLapTotalTime();
      expect(returnValue, 321);
      bloc.add(
        UpdateEvent(
          bloc.state.copyWith(
            laps: [
              Lap(
                lapPlace: LapPlace.neutral,
                lapTime: 456,
                totalTime: 789,
              ),
            ],
          ),
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
      returnValue = bloc.getLastLapTotalTime();
      expect(returnValue, 789);
    });

    test('setLapPlaces() returns correct values', () async {
      WidgetsFlutterBinding.ensureInitialized();
      final List<Lap> initialLaps = [
        Lap(
          lapPlace: LapPlace.neutral,
          lapTime: 345,
          totalTime: 321,
        ),
        Lap(
          lapPlace: LapPlace.slowest,
          lapTime: 123,
          totalTime: 321,
        ),
        Lap(
          lapPlace: LapPlace.fastest,
          lapTime: 234,
          totalTime: 321,
        ),
        Lap(
          lapPlace: LapPlace.neutral,
          lapTime: 567,
          totalTime: 321,
        ),
        Lap(
          lapPlace: LapPlace.neutral,
          lapTime: 1000,
          totalTime: 321,
        ),
      ];
      final updatedLaps = bloc.setLapPlaces(initialLaps);
      expect(updatedLaps[0].lapPlace, LapPlace.neutral);
      expect(updatedLaps[1].lapPlace, LapPlace.fastest);
      expect(updatedLaps[2].lapPlace, LapPlace.neutral);
      expect(updatedLaps[3].lapPlace, LapPlace.slowest);
      // the last lap doesn't count since it is typically still running
      expect(updatedLaps[4].lapPlace, LapPlace.neutral);
    });

    test('bloc closes', () async {
      final bloc = StopwatchBloc();
      bloc.timer = Timer(Duration.zero, () {});
      await bloc.close();
      await Future.delayed(const Duration(seconds: 1));
      expectLater(bloc.isClosed, true);
    });
  });
}
