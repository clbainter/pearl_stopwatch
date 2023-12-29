import 'dart:async';

import 'package:bloc_widget_arch/bloc/base_arch_bloc.dart';
import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/stopwatch_event.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/stopwatch_state.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/model/index.dart';

class StopwatchBloc extends BaseArchBloc<StopwatchState> {
  StopwatchBloc()
      : super(
          StopwatchState(
            isStarted: false,
            laps: [],
            storedTime: 0,
            timeElapsed: 0,
          ),
        );

  @override
  EventBus get eventBus => EventBusSingleton().eventBus;

  final Stopwatch _stopwatch = Stopwatch();
  late Timer timer;

  @override
  void registerEvents() {
    super.registerEvents();
    listen<StartEvent>(handleStartEvent);
    listen<StopEvent>(handleStopEvent);
    listen<LapEvent>(handleLapEvent);
    listen<ResetEvent>(handleResetEvent);
  }

  // Event Handlers
  void handleStartEvent(StartEvent event) {
    startTimer();
    Logger.log(
      'StartEvent received: $event',
      tag: runtimeType.toString(),
    );
  }

  void handleStopEvent(StopEvent event) {
    stopTimer();
    Logger.log(
      'StopEvent received: $event',
      tag: runtimeType.toString(),
    );
  }

  void handleResetEvent(ResetEvent event) {
    resetStopwatch();
    Logger.log(
      'ResetEvent received: $event',
      tag: runtimeType.toString(),
    );
  }

  void handleLapEvent(LapEvent event) {
    setLap();
    Logger.log(
      'LapEvent received: $event',
      tag: runtimeType.toString(),
    );
  }

  // Helper Functions

  void startTimer() {
    _stopwatch
      ..reset()
      ..start();
    timer = Timer.periodic(
      const Duration(milliseconds: 8),
      (timer) {
        updateTime();
      },
    );
    add(
      UpdateEvent(
        state.copyWith(
          isStarted: true,
        ),
      ),
    );
  }

  void updateTime() {
    int lapTime = state.storedTime + _stopwatch.elapsedMilliseconds;
    List<Lap> laps = state.laps;
    int? totalTime;
    if (laps.isNotEmpty) {
      int totalTime = laps.fold<int>(0, (sum, lap) => sum + lap.lapTime) -
          laps.last.lapTime +
          lapTime;
      laps.last = Lap(
        lapTime: lapTime,
        lapPlace: LapPlace.neutral,
        totalTime: totalTime,
      );
    } else {
      laps.add(
        Lap(
          lapTime: lapTime,
          lapPlace: LapPlace.neutral,
          totalTime: lapTime,
        ),
      );
    }
    add(
      UpdateEvent(
        state.copyWith(
          timeElapsed: totalTime ?? lapTime,
          laps: laps,
        ),
      ),
    );
  }

  void setLap() {
    int lapTime = state.storedTime + _stopwatch.elapsedMilliseconds;
    timer.cancel();
    _stopwatch.reset();
    List<Lap> updatedLaps = [
      ...state.laps,
      Lap(
        lapTime: lapTime,
        lapPlace: LapPlace.neutral,
        totalTime: state.timeElapsed,
      ),
    ];
    add(
      UpdateEvent(
        state.copyWith(
          storedTime: 0,
          laps: setLapPlaces(updatedLaps),
        ),
      ),
    );
    eventBus.fire(
      StartEvent(),
    );
  }

  List<Lap> setLapPlaces(List<Lap> laps) {
    if (laps.length > 2) {
      // Exclude the last lap
      final lapsToCompare = laps.sublist(0, laps.length - 1);

      // Find the fastest and slowest lap times
      int fastestLapTime = lapsToCompare.first.lapTime;
      int slowestLapTime = lapsToCompare.first.lapTime;

      for (final lap in lapsToCompare) {
        if (lap.lapTime < fastestLapTime) {
          fastestLapTime = lap.lapTime;
        } else if (lap.lapTime > slowestLapTime) {
          slowestLapTime = lap.lapTime;
        }
      }

      // Update LapPlace for each lap
      final updatedLaps = laps.map((lap) {
        if (lap.lapTime == fastestLapTime) {
          return Lap(
            lapPlace: LapPlace.fastest,
            lapTime: lap.lapTime,
            totalTime: lap.totalTime,
          );
        } else if (lap.lapTime == slowestLapTime) {
          return Lap(
            lapPlace: LapPlace.slowest,
            lapTime: lap.lapTime,
            totalTime: lap.totalTime,
          );
        } else {
          return Lap(
            lapPlace: LapPlace.neutral,
            lapTime: lap.lapTime,
            totalTime: lap.totalTime,
          );
        }
      }).toList();

      return updatedLaps;
    }
    return laps;
  }

  void resetStopwatch() {
    timer.cancel();
    _stopwatch.reset();
    add(
      UpdateEvent(
        state.copyWith(
          isStarted: false,
          timeElapsed: 0,
          storedTime: 0,
          laps: [],
        ),
      ),
    );
  }

  void stopTimer() {
    add(
      UpdateEvent(
        state.copyWith(
          isStarted: false,
          storedTime: state.timeElapsed,
        ),
      ),
    );
    timer.cancel();
  }

  String formatTime(int milliseconds) {
    int minutes = (milliseconds / 60000).floor();
    int leftoverMilliseconds = milliseconds % 60000;
    double seconds = (leftoverMilliseconds / 1000);
    String minuteString = minutes.toString().padLeft(2, '0');
    return '$minuteString:${seconds.toStringAsFixed(2)}';
  }

  int getLastLapTotalTime() {
    return state.laps.isEmpty ? 0 : state.laps.last.totalTime;
  }

  @override
  Future<void> close() async {
    timer.cancel();
    _stopwatch.stop();
    super.close();
  }
}
