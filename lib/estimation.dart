import 'package:flutter/material.dart';

class Estimation extends StatefulWidget {
  const Estimation({super.key});

  @override
  State<Estimation> createState() => _EstimationState();
}

class _EstimationState extends State<Estimation> {
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              top: _startAnimation ? 0 : -screenHeight * 0.4,
              left: 0,
              right: 0,
              child: Container(

                // height: MediaQuery.of(context).size.height * 0.32,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF3F5FF),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80.0),
                  ),
                ),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 40),
                    Row(

                      children: [
                        // Profile Picture (Image)
                        ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 40, // Width of the image
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 15),
                        // Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Listing ID:  AB1234",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat-Medium',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff414141)),
                            ),
                            Text(
                              "Hi,John Doe",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat-Medium',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff414141)),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(top: 20,right: 5),
                      child: Padding(
                        padding:  EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width:200,
                              child: Text(
                                "Estimation",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                              width:200,
                              child: Text(
                                "HD camera capture images and videos in 1920x1080 pixels and a resolution of 1080p",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat-Medium',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff414141)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 10,top: 130),
              child:   AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                left: _startAnimation ? 0 : -MediaQuery.of(context).size.width,
                child: Container(

                  height: MediaQuery.of(context).size.height * 0.2,

                  width: MediaQuery.of(context).size.width *0.25,

                  child: Image(image: AssetImage('assets/images/estimation.png'),height: 100),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              bottom: _startAnimation ? 0 : -screenHeight * 0.5,
              left: 0,
              right: 0,
              child:Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF3F5FF),
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),child: Padding(
                padding:  EdgeInsets.only(top: 20,right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:200,
                            child: Text(
                              "Product configuration and preview",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            width:200,
                            child: Text(
                              "HD camera capture images and videos in 1920x1080 pixels and a resolution of 1080p",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat-Medium',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff414141)),
                            ),
                          ),


                          Container(
                            width:200,
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Montserrat-Medium',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff414141)),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}