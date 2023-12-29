import 'package:pearl_stopwatch/screens/stopwatch/src/model/lap.dart';

class StopwatchState {
  final bool isStarted;
  final List<Lap> laps;
  final int storedTime;
  final int timeElapsed;

  StopwatchState({
    required this.isStarted,
    required this.laps,
    required this.storedTime,
    required this.timeElapsed,
  });
}

extension StopwatchStateCopyWith on StopwatchState {
  StopwatchState copyWith({
    bool? isStarted,
    List<Lap>? laps,
    int? storedTime,
    int? timeElapsed,
  }) {
    return StopwatchState(
      isStarted: isStarted ?? this.isStarted,
      laps: laps ?? this.laps,
      storedTime: storedTime ?? this.storedTime,
      timeElapsed: timeElapsed ?? this.timeElapsed,
    );
  }
}
