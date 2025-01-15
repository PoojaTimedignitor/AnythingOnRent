import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'FAQ.dart';
class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}
class _HelpCenterState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xffF5F6FB),
      appBar: AppBar(
        title: Text(
          "Help Center",
          style: TextStyle(
            fontFamily: "Montserrat-Medium",
            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
            color: CommonColor.TextBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container (
          height: SizeConfig.screenHeight * 0.3,
          width: SizeConfig.screenWidth,

          child: Column(
            children: [
              Image(image: AssetImage('assets/images/ticket.png'), height: SizeConfig.screenHeight * 0.18),
              SizedBox(height: 16),
              Text("You havent't bought any tiket yet", style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),)
            ],
          ),
        ),
        Padding(
  padding: const EdgeInsets.all(13.0),
  child: Container(
    height: 40,
width: SizeConfig.screenHeight*0.5,
    decoration: BoxDecoration(
      color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))

    ),child: GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FAQ()),
      );
    },
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.help_outline, // Icon before the text
              color: Colors.black,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              " Need Help? Contact Us",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "okra_Medium",
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
          ],
        )

        ),
    ),

  ),
),
        Padding(
          padding: EdgeInsets.only(top: 4,left: 10,right: 10),
          child: Container(
            height: 40,
            width: SizeConfig.screenHeight*0.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))

            ),child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help_outline, // Icon before the text
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    " Terms and conditions",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                ],
              )

          ),

          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 14,left: 10,right: 10),
          child: Container(
            height: 40,
            width: SizeConfig.screenHeight*0.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))

            ),child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help_outline, // Icon before the text
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    " Privacy Policy",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                ],
              )

          ),

          ),
        ),
        SizedBox(height: 50),
        Text("    ANYTHING ON RENT",  style: TextStyle(
          fontFamily: "okra_extrabold",
          fontSize: SizeConfig.blockSizeHorizontal * 5.5,
          color: Color(0xffC6C6C6),
          fontWeight: FontWeight.w600,
        ))
      ],
    ),
    );
  }





}


