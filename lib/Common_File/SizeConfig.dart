import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double safeUsedHeight = 0.0;

  static double screenTop = 0.0;
  static double screenBottom = 0.0;
  static double blockSizeHorizontal = 0.0;
  static double blockSizeVertical = 0.0;
  static double safeAreaHorizontal = 0.0;
  static double safeAreaVertical = 0.0;
  static double safeBlockHorizontal = 0.0;
  static double safeBlockVertical = 0.0;

  // New additions
  static double devicePixelRatio = 1.0;
  static bool isTablet = false;
  static bool isDesktop = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    screenTop = _mediaQueryData.padding.top;
    screenBottom = _mediaQueryData.padding.bottom;
    safeUsedHeight = screenHeight - screenTop - screenBottom;

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - safeAreaVertical) / 100;

    // DPI Support
    devicePixelRatio = _mediaQueryData.devicePixelRatio;

    // Breakpoints for tablet & desktop
    isTablet = screenWidth > 600;
    isDesktop = screenWidth > 1200;
  }
}
