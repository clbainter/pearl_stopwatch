import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/widgets/index.dart';

class StopwatchMobileLandscape extends StatelessBlocWidget<StopwatchBloc, StopwatchState> {
  const StopwatchMobileLandscape({super.key});

  @override
  StopwatchBloc get bloc => Modular.get<StopwatchBloc>();

  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StopwatchStrings.appBarLabel,
        ),
        backgroundColor: AppColors.secondary,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 360.0,
                ),
                color: AppColors.background,
                child: const LapTable(),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: AppColors.primary,
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 360.0,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StopwatchTimer(),
                      StopwatchButtonsSm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
