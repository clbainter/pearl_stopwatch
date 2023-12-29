import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pearl_stopwatch/arch/responsive_layout.dart';

void main() {
  group('ResponsiveLayout Tests', () {
    const key = Key('theKey');
    const mpKey = Key('mpKey');
    const mlKey = Key('mlKey');
    const tabKey = Key('tabKey');
    const lapKey = Key('lapKey');
    final Widget mobileP = Container(key: mpKey);
    final Widget mobileL = Container(key: mlKey);
    final Widget tablet = Container(key: tabKey);
    final Widget laptop = Container(key: lapKey);

    Widget getLayout(
      double width, {
      bool passLand = true,
      bool passTab = true,
      bool passLap = true,
    }) {
      return MaterialApp(
        home: Scaffold(
          body: ResponsiveLayout(
            key: key,
            mobilePortrait: () => mobileP,
            mobileLandscape: passLand ? () => mobileL : null,
            tablet: passTab ? () => tablet : null,
            laptopPlus: passLap ? () => laptop : null,
            testWidth: width,
          ),
        ),
      );
    }

    testWidgets('mobilePortrait', (widgetTester) async {
      final widget = getLayout(500);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(mpKey), findsOneWidget);
    });

    testWidgets('mobileLandscape', (widgetTester) async {
      // test with mobileLandscape
      var widget = getLayout(800);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(mlKey), findsOneWidget);
      // test without mobileLandscape
      widget = getLayout(800, passLand: false);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(mpKey), findsOneWidget);
    });

    testWidgets('tablet', (widgetTester) async {
      // test with tablet
      var widget = getLayout(1200);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(tabKey), findsOneWidget);
      // test without tablet, with mobileLandscape
      widget = getLayout(1200, passTab: false);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(mlKey), findsOneWidget);
      // test without tablet, without mobileLandscape
      widget = getLayout(1200, passTab: false, passLand: false);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(mpKey), findsOneWidget);
    });

    testWidgets('laptop', (widgetTester) async {
      // test with laptop
      var widget = getLayout(1400);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(lapKey), findsOneWidget);
      // test without laptop, with tablet
      widget = getLayout(1400, passLap: false);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(tabKey), findsOneWidget);
      // test without laptop, without tablet, with mobileLand
      widget = getLayout(1400, passLap: false, passTab: false);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(mlKey), findsOneWidget);
      // test without laptop, tablet, or mobileLand
      widget = getLayout(1400, passLap: false, passTab: false, passLand: false);
      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();
      expect(find.byKey(key), findsOneWidget);
      expect(find.byKey(mpKey), findsOneWidget);
    });
  });
}
