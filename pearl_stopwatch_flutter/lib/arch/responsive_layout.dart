import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget Function() mobilePortrait;
  final Widget Function()? mobileLandscape;
  final Widget Function()? tablet;
  final Widget Function()? laptopPlus;
  final double? testWidth;

  const ResponsiveLayout({
    super.key,
    required this.mobilePortrait,
    this.mobileLandscape,
    this.tablet,
    this.laptopPlus,
    this.testWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = testWidth ?? MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (_, __) {
        Widget Function() builder = mobilePortrait;
        if (screenWidth <= 600) {
          builder = mobilePortrait;
        } else if (screenWidth > 600 && screenWidth <= 960) {
          builder = mobileLandscape ?? mobilePortrait;
        } else if (screenWidth > 960 && screenWidth <= 1280) {
          builder = tablet ?? mobileLandscape ?? mobilePortrait;
        } else if (screenWidth > 1280) {
          builder = laptopPlus ?? tablet ?? mobileLandscape ?? mobilePortrait;
        }
        return builder();
      },
    );
  }
}
