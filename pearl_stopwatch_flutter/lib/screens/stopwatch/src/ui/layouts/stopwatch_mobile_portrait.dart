import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/widgets/index.dart';

class StopwatchMobilePortrait
    extends StatelessBlocWidget<StopwatchBloc, StopwatchState> {
  const StopwatchMobilePortrait({super.key});

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
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primary,
              constraints: const BoxConstraints(
                minHeight: 300,
              ),
              child: Column(
                children: [
                  const StopwatchTimer(),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 480,
                    ),
                    child: const StopwatchButtonsSm(),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: LapTable(),
            ),
          ],
        ),
      ),
    );
  }
}
