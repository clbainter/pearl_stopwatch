import 'package:pearl_stopwatch/arch/index.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_strings.dart';

class LapHeader extends StatelessWidget {
  const LapHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 48.0,
      ),
      child: Row(
        children: [
          Text(
            StopwatchStrings.lapNumberHeader,
            style: AppTextStyles.lapHeader,
          ),
          const Spacer(),
          Text(
            StopwatchStrings.lapTimeHeader,
            style: AppTextStyles.lapHeader,
          ),
          const Spacer(),
          Text(
            StopwatchStrings.totalTimeHeader,
            style: AppTextStyles.lapHeader,
          ),
        ],
      ),
    );
  }
}
