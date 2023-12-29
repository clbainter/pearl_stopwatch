class Lap {
  final LapPlace lapPlace;
  final int lapTime;
  final int totalTime;

  Lap({
    required this.lapPlace,
    required this.lapTime,
    required this.totalTime,
  });
}

enum LapPlace {
  fastest,
  neutral,
  slowest,
}
