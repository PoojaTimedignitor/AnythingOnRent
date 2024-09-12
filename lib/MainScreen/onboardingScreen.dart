import 'package:anything/MainScreen/register_screen.dart';
import 'package:flutter/material.dart';

import '../CommonWidget.dart';
import 'onBoardingContent.dart';
class onboardingScreen extends StatefulWidget {
   onboardingScreen({super.key});

  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}
late PageController _controller;

class _onboardingScreenState extends State<onboardingScreen> {
  @override
  void initState() {
    _controller = PageController();
    super.initState();

  }
  int _currentPage = 0;
  List colors =  [
    Color(0xFFDAECFD),
    Color(0xffEAE1FF),
    Color(0xfffde2d9),
  ];

  List colorss = const [
    Color(0xffC3DFFA),
    Color(0xffD0C5F6),
    Color(0xffffcdb9),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration:  Duration(milliseconds: 200),
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),


            color:Color(0xff443037),
           // Color(0xff64BFD3)
          ),


      margin:  EdgeInsets.only(right: 5),
      height: 8,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: colors[_currentPage],
        body:
          SafeArea(
            child: Column(
              children: [

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    width: SizeConfig.screenWidth*0.35,
                    height: SizeConfig.screenHeight*0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
                        color: colorss[_currentPage],
                        ),
                   ),
              ),


                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) => setState(() => _currentPage = value),
                    itemCount: contents.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            Image.asset(
                              contents[i].image,
                              height: SizeConfig.screenHeight * 0.20,
                            ),
                            SizedBox(
                              height: (SizeConfig.screenHeight >= 840) ? 60 : 30,
                            ),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Montserrat-Medium',
                                fontWeight: FontWeight.w600,
                                fontSize: (SizeConfig.screenWidth <= 550) ?26 : 32,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              contents[i].desc,
                              style: TextStyle(
                                fontFamily: 'Montserrat-Regular',
                                fontWeight: FontWeight.w300,
                                fontSize: (SizeConfig.screenWidth <= 550) ? 16 : 25,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                              (int index) => _buildDots(
                            index: index,
                          ),
                        ),
                      ),
                      _currentPage + 1 == contents.length
                          ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Stack(
                          children: [
                            ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Text("START"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffFFAC8E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),

                                ),
                                padding: (SizeConfig.screenWidth <= 650)
                                    ? const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 20)
                                    : EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth * 0.1, vertical: 25),
                                textStyle:
                                TextStyle(fontSize: (SizeConfig.screenWidth <= 550) ? 13 : 17),
                              ),
                            ),


                          ],
                        ),


                     /*   Container(
                          height: SizeConfig.screenHeight*0.06,
                          width: SizeConfig.screenWidth*0.5,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff61A5A9), Color(0xff9BDADE)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Set the button background to transparent
                              shadowColor: Colors.transparent, // Remove the shadow for cleaner look
                              padding: EdgeInsets.all(16.0),
                            ),
                            child: Text("START",style: TextStyle(color: Colors.white),),
                          ),

                      )*/
                      )
                          : Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                _controller.jumpToPage(2);
                              },
                              child:  Text(
                                "Skip",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: TextButton.styleFrom(
                                elevation: 0,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat-Medium',
                                  fontSize: (SizeConfig.screenWidth <= 550) ? 18 : 17,
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                _controller.nextPage(
                                  duration:  Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              },
                              child: PhysicalShape(
                                color: Color(0xff61A5A9),
                                shadowColor: Colors.grey.shade300,
                                elevation: 10,
                                clipper: ShapeBorderClipper(shape: CircleBorder()),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child:Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  ),

                                ),
                              ),
                            )



                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: SizeConfig.screenWidth*0.35,
                      height: SizeConfig.screenHeight*0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
                        color: colorss[_currentPage],
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
