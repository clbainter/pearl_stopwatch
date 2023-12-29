import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/layouts/index.dart';

class StopwatchScreen
    extends StatelessBlocWidget<StopwatchBloc, StopwatchState> {
  const StopwatchScreen({super.key});

  @override
  StopwatchBloc get bloc => Modular.get<StopwatchBloc>();

  @override
  Widget onBuild(BuildContext context) {
    return ResponsiveLayout(
      mobilePortrait: mobilePortrait,
      mobileLandscape: mobileLandscape,
      tablet: tablet,
      laptopPlus: laptopPlus,
    );
  }

  Widget mobilePortrait() => const StopwatchMobilePortrait();

  Widget mobileLandscape() => const StopwatchMobileLandscape();

  Widget tablet() => const StopwatchTablet();

  Widget laptopPlus() => const StopwatchLaptopPlus();
}
