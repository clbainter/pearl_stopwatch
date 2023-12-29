import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/model/index.dart';

void main() {
  group('StopwatchState Tests', () {
    test('correct object returned', () async {
      final StopwatchState state = StopwatchState(
        isStarted: false,
        laps: [],
        storedTime: 0,
        timeElapsed: 0,
      );
      expect(state.isStarted, false);
      expect(state.laps.length, 0);
      expect(state.storedTime, 0);
      expect(state.timeElapsed, 0);
    });

    test('copyWith returns updated object', () async {
      final StopwatchState state = StopwatchState(
        isStarted: false,
        laps: [],
        storedTime: 0,
        timeElapsed: 0,
      );
      expect(state.isStarted, false);
      expect(state.laps.length, 0);
      expect(state.storedTime, 0);
      expect(state.timeElapsed, 0);

      // update isStarted
      var updated = state.copyWith(isStarted: true);
      expect(updated.isStarted, true);
      expect(updated.laps.length, 0);
      expect(updated.storedTime, 0);
      expect(updated.timeElapsed, 0);

      // update laps
      updated = updated.copyWith(
        laps: [
          Lap(
            lapPlace: LapPlace.neutral,
            lapTime: 123,
            totalTime: 345,
          ),
        ],
      );
      expect(updated.isStarted, true);
      expect(updated.laps.length, 1);
      expect(updated.storedTime, 0);
      expect(updated.timeElapsed, 0);

      // update storedTime
      updated = updated.copyWith(
        storedTime: 987
      );
      expect(updated.isStarted, true);
      expect(updated.laps.length, 1);
      expect(updated.storedTime, 987);
      expect(updated.timeElapsed, 0);

      // update timeElapsed
      updated = updated.copyWith(
          timeElapsed: 567
      );
      expect(updated.isStarted, true);
      expect(updated.laps.length, 1);
      expect(updated.storedTime, 987);
      expect(updated.timeElapsed, 567);
    });
  });
}
