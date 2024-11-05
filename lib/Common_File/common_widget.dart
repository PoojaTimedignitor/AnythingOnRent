import 'package:anything/Common_File/common_color.dart';
import 'package:flutter/material.dart';

import 'SizeConfig.dart';
class CommonWidget extends StatefulWidget {
  final String text;
  final String texttwo;
  final String textthree;
  final String textfour;


  const CommonWidget({super.key, required this.text, required this.texttwo, required this.textthree, required this.textfour});

  @override
  State<CommonWidget> createState() => _CommonWidgetState();
}

class _CommonWidgetState extends State<CommonWidget> {

//Color TapColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 55,
          width: 80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38,width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))

          ),child: Stack(

            children: [
              Padding(
                padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02),
                child: Image(image: AssetImage('assets/images/catone.png'),height: 38,width: 75),
              ),
                Padding(
                  padding:  EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text(

                                    widget.text,

                                    style: TextStyle(
                                      color: CommonColor.Black,
                                      fontFamily: "Roboto_Regular",
                                      fontSize: SizeConfig.blockSizeHorizontal * 2.7,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                  ),
                ),
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
           /* setState(() {

              print("colorsss....$TapColor");
              TapColor = TapColor == Colors.transparent ?
                  Colors.blueAccent:
                  Colors.transparent;

            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginScreen(*//*address: '', lat: '', long: '', ProfilePicture: '', FrontImage: '', BackImage: '',*//*)),
            );*/

          },
          child: Container(
            height: 55,
            width: 80,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38,width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              //color: TapColor,
            ),child: Stack(

            children: [
              Padding(
                padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02,bottom: 20),
                child: Image(image: AssetImage('assets/images/cattwo.png'),height: 72,width: 108),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 30),
                child: Center(
                  child: Text (
                    widget.texttwo,
                    style: TextStyle(
                      color: CommonColor.Black,
                      fontFamily: "Roboto_Regular",
                      fontSize: SizeConfig.blockSizeHorizontal * 2.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          ),
        ),
        Container(
          height: 55,
          width: 80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38,width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))

          ),child: Stack(

          children: [
            Padding(
              padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02),
              child: Image(image: AssetImage('assets/images/catthree.png'),height: 37,width: 75),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 30),
              child: Center(
                child: Text(

                  widget.textthree,

                  style: TextStyle(
                    color: CommonColor.Black,
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 2.7,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
        Container(
          height: 55,
          width: 80,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black38,width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))

          ),child: Stack(

          children: [
            Padding(
              padding:  EdgeInsets.only(left:SizeConfig.screenWidth*0.02,top: SizeConfig.screenHeight*0.002),
              child: const Image(image: AssetImage('assets/images/catfour.png'),height:30,width: 75),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 30),
              child: Center(
                child: Text(

                  widget.textfour,

                  style: TextStyle(
                    color: CommonColor.Black,
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 2.7,
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
