import 'package:anything/Common_File/common_color.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';
class CommonWidget extends StatefulWidget {
  final String text;
  final String texttwo;


  const CommonWidget({super.key, required this.text, required this.texttwo});

  @override
  State<CommonWidget> createState() => _CommonWidgetState();
}

class _CommonWidgetState extends State<CommonWidget> {


  @override
  Widget build(BuildContext context) {

    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 60,
          width: 90,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(13))

          ),child: Stack(

            children: [
              Padding(
                padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02),
                child: Image(image: AssetImage('assets/images/catone.png'),height: 42,width: 78),
              ),
                Padding(
                  padding:  EdgeInsets.only(top: 35),
                  child: Center(
                    child: Text(

                                    widget.text,

                                    style: TextStyle(
                                      color: CommonColor.Black,
                                      fontFamily: "Roboto_Regular",
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: 90,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(13))

          ),child: Stack(

          children: [
            Padding(
              padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02,bottom: 20),
              child: Image(image: AssetImage('assets/images/cattwo.png'),height: 62,width: 88),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 35),
              child: Center(
                child: Text (
                  widget.texttwo,
                  style: TextStyle(
                    color: CommonColor.Black,
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
        Container(
          height: 60,
          width: 90,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(13))

          ),child: Stack(

          children: [
            Padding(
              padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02),
              child: Image(image: AssetImage('assets/images/catthree.png'),height: 42,width: 78),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 35),
              child: Center(
                child: Text(

                  widget.text,

                  style: TextStyle(
                    color: CommonColor.Black,
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
        Container(
          height: 60,
          width: 90,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(13))

          ),child: Stack(

          children: [
            Padding(
              padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02),
              child: const Image(image: AssetImage('assets/images/catfour.png'),height:35,width: 78),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 35),
              child: Center(
                child: Text(

                  widget.text,

                  style: TextStyle(
                    color: CommonColor.Black,
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ],
    );
  }
}

/*  Text(

                widget.text,

                style: TextStyle(
                  color: CommonColor.Black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontWeight: FontWeight.w600,
                ),
              ),*/