import 'package:pearl_stopwatch/app_module.dart';
import 'package:pearl_stopwatch/screens/stopwatch/src/ui/stopwatch_screen.dart';

import 'arch/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const StopwatchApp(),
    ),
  );
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StopwatchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
