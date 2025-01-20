/*import 'package:flutter/material.dart';

class StarAnimationExample extends StatefulWidget {
  @override
  _StarAnimationExampleState createState() => _StarAnimationExampleState();
}

class _StarAnimationExampleState extends State<StarAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 1.0,
      upperBound: 1.07,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zoom In-Out Star Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _controller.value,
              child: child,
            );
          },

          child: Container(
            width: 300,
            height: 57,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(12)),
              gradient: RadialGradient(
                colors: [Colors.yellow, Colors.orange],
                center: Alignment.center,
                radius: 0.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5),
                  blurRadius: 9,
                  spreadRadius: 1,
                ),
              ],
            ),
            child:Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(



                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(12)),
                ),child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("On our platform, you can both sell and rent your products",style: TextStyle(

                        fontFamily:
                        "Montserrat-Italic",
                        color:
                      Colors.black,
                      fontWeight:
                      FontWeight.w500,
                      fontSize: 14),

                  maxLines: 2),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'Admin/FAQ.dart';
import 'Admin/helpCentre.dart';
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
              Text("You havent't bought any ticket yet", style: TextStyle(
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

            ),child: InkWell(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpCenterScreen(initialIndex: 1),
                ),
              );
            },
            child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline,
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
