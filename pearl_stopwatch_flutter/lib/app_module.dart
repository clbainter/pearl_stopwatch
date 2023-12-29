import 'package:flutter_modular/flutter_modular.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/stopwatch_bloc.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<StopwatchBloc>(
      () => StopwatchBloc(),
    );
  }
}
