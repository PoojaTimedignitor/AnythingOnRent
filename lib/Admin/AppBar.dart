import 'package:flutter/material.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';

AppBar buildAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontFamily: "Montserrat-Medium",
        fontSize: SizeConfig.blockSizeHorizontal * 4.5,
        color: CommonColor.TextBlack,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
  );
}
