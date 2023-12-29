import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';

class StopwatchTimer
    extends StatelessBlocWidget<StopwatchBloc, StopwatchState> {
  const StopwatchTimer({super.key});

  @override
  StopwatchBloc get bloc => Modular.get<StopwatchBloc>();

  @override
  Widget onBuild(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 150.0,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      child: Center(
        child: Text(
          bloc.formatTime(
            bloc.getLastLapTotalTime(),
          ),
          style: AppTextStyles.timerLg,
        ),
      ),
    );
  }
}
