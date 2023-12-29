import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/reusable_components/buttons/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';
import 'package:v_widgets/v_widgets.dart';

class StopwatchButtonsLg
    extends StatelessBlocWidget<StopwatchBloc, StopwatchState> {
  const StopwatchButtonsLg({super.key});

  @override
  StopwatchBloc get bloc => Modular.get<StopwatchBloc>();

  @override
  Widget onBuild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 64.0,
        right: 64.0,
        top: 0.0,
        bottom: 32.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Vif(
            test: () => bloc.state.isStarted,
            ifTrue: () => SecondaryButton(
              onPressed: () {
                bloc.eventBus.fire(
                  LapEvent(),
                );
              },
              text: StopwatchStrings.lapButtonText,
              textColor: AppColors.primary,
              buttonColor: AppColors.primary,
              textStyle: AppTextStyles.button,
            ),
            ifFalse: () => SecondaryButton(
              onPressed: () {
                bloc.eventBus.fire(
                  ResetEvent(),
                );
              },
              text: StopwatchStrings.resetButtonText,
              textColor: AppColors.onButtonDark,
              buttonColor: AppColors.buttonNeutral,
              textStyle: AppTextStyles.button,
            ),
          ),
          Vif(
            test: () => bloc.state.isStarted,
            ifTrue: () => PrimaryButton(
              onPressed: () {
                bloc.eventBus.fire(
                  StopEvent(),
                );
              },
              text: StopwatchStrings.stopButtonText,
              textColor: AppColors.onButtonDark,
              buttonColor: AppColors.buttonStop,
              textStyle: AppTextStyles.button,
            ),
            ifFalse: () => PrimaryButton(
              onPressed: () {
                bloc.eventBus.fire(
                  StartEvent(),
                );
              },
              text: StopwatchStrings.startButtonText,
              textColor: AppColors.onButtonDark,
              buttonColor: AppColors.buttonStart,
              textStyle: AppTextStyles.button,
            ),
          ),
        ],
      ),
    );
  }
}
