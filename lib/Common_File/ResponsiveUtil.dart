import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUtil {

  static double fontSize(double size) {
    return size * (MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width / 375);}

  /*static double fontSize(double size) {
    return size.sp;
  }*/

  static double height(double size) {
    return size.h;
  }

  static double width(double size) {
    return size.w;
  }
}
