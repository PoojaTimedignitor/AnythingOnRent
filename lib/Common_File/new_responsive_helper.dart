import 'package:flutter/widgets.dart';
import 'dart:math';

class ResponsiveHelper {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  ResponsiveHelper(this.context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery != null) {
      screenWidth = max(mediaQuery.size.width, 1);
      screenHeight = max(mediaQuery.size.height, 1);
    } else {
      screenWidth = 375;
      screenHeight = 812;
    }
  }


  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;


  double width(double value) => (value / 375) * screenWidth;


  double height(double value) => (value / 812) * screenHeight;


  EdgeInsets getPadding({double all = 0, double vertical = 0, double horizontal = 0}) {
    return EdgeInsets.symmetric(
      vertical: height(vertical),
      horizontal: width(horizontal),
    ).copyWith(
      left: width(all), right: width(all), top: height(all), bottom: height(all),
    );
  }



  EdgeInsets getMargin({double all = 0, double vertical = 0, double horizontal = 0}) {
    return getPadding(all: all, vertical: vertical, horizontal: horizontal);
  }

  double fontSize(double size) => (size / 375) * screenWidth;

  static double getFontSize(BuildContext context, double baseSize) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {

      return baseSize * 0.9;
    } else if (width < 1200) {

      return baseSize * 1.1;
    } else {

      return baseSize * 1.3;
    }
  }

}



