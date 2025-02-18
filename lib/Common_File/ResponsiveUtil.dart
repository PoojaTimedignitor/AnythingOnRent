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


  bool isMobile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < 600; // Mobile screen (width less than 600px)
  }

  bool isTablet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024; // Tablet screen (width between 600px and 1024px)
  }

  bool isDesktop(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 1024; // Desktop screen (width 1024px or more)
  }

}
