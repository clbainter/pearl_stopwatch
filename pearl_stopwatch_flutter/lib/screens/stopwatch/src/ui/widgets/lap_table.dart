import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/bloc/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/model/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';
import 'package:v_widgets/v_widgets.dart';

class LapTable extends StatelessBlocWidget<StopwatchBloc, StopwatchState> {
  final bool includeTotalColumn;
  final double maxWidth;

  const LapTable({
    super.key,
    this.includeTotalColumn = false,
    this.maxWidth = 360.0,
  });

  @override
  StopwatchBloc get bloc => Modular.get<StopwatchBloc>();

  @override
  Widget onBuild(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 48.0,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          reverse: false,
          itemBuilder: (BuildContext context, int index) {
            // get indexes in reverse order
            int oppositeIndex = bloc.state.laps.length - 1 - index;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text(
                    '${StopwatchStrings.lapLabel} ${oppositeIndex + 1}',
                    style: AppTextStyles.timerSm.copyWith(
                      color: getTextColor(
                        bloc.state.laps[oppositeIndex].lapPlace,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    bloc.formatTime(
                      bloc.state.laps[oppositeIndex].lapTime,
                    ),
                    style: AppTextStyles.timerSm.copyWith(
                      color: getTextColor(
                        bloc.state.laps[oppositeIndex].lapPlace,
                      ),
                    ),
                  ),
                  Vif(
                    test: () => includeTotalColumn,
                    ifTrue: () => const Spacer(),
                  ),
                  Vif(
                    test: () => includeTotalColumn,
                    ifTrue: () => Text(
                      bloc.formatTime(
                        bloc.state.laps[oppositeIndex].totalTime,
                      ),
                      style: AppTextStyles.timerSm.copyWith(
                        color: getTextColor(
                          bloc.state.laps[oppositeIndex].lapPlace,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 1.0,
              color: AppColors.text,
            );
          },
          itemCount: bloc.state.laps.length,
        ),
      ),
    );
  }

  Color getTextColor(LapPlace lapPlace) {
    switch (lapPlace) {
      case LapPlace.fastest:
        return AppColors.success;
      case LapPlace.neutral:
        return AppColors.text;
      case LapPlace.slowest:
        return AppColors.error;
    }
  }
}
