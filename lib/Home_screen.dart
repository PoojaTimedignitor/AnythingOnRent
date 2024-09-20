import 'package:anything/CommonWidget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'bottomNavigationBar.dart';
import 'common_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final _searchFocus = FocusNode();
  final searchController = TextEditingController();
  int currentIndex = 0;
  int _currentIndex = 0;
  int _counter = 0;


  final List<String> images = [
    "https://img.freepik.com/free-vector/gradient-car-rental-twitch-background_23-2149238538.jpg?w=1380&t=st=1724674607~exp=1724675207~hmac=0ab319f9d9411c32c9d26508151d51f62139e048ac598796c8463dac3ef0aad7"'https://img.freepik.com/free-vector/real-estate-landing-page_23-2148686374.jpg?w=1380&t=st=1724741972~exp=1724742572~hmac=e21195893cb55e204d9618c983abd7d4d1dc18402402af3dbe0420bd08d6ad33',
    "https://img.freepik.com/free-vector/hand-drawn-real-estate-poster-template_23-2149845735.jpg?w=740&t=st=1724742124~exp=1724742724~hmac=3920ca483a7e7dc65a3006016da9687799d3d72e35d5a70af985ce681bbdfc49"'https://images.pexels.com/photos/3757226/pexels-photo-3757226.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/13065690/pexels-photo-13065690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/372810/pexels-photo-372810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/4489702/pexels-photo-4489702.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),


        padding: EdgeInsets.zero,
        children: [
          getAddMainHeadingLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
          HomeSearchBar(SizeConfig.screenHeight, SizeConfig.screenWidth),
          sliderData(SizeConfig.screenHeight, SizeConfig.screenWidth),
          AddPostButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
          Stack(
            children: [
              Padding(
                padding:
                EdgeInsets.only(left: SizeConfig.screenWidth * 0.68, top: 216),
                child: Image(
                  image: AssetImage('assets/images/home.png'),
                  height: SizeConfig.screenHeight * 0.220,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.53),
                child: Image(
                  image: AssetImage('assets/images/homecircle.png'),
                  height: SizeConfig.screenHeight * 0.150,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.69),
                child: Image(
                  image: AssetImage('assets/images/homecircle.png'),
                  height: SizeConfig.screenHeight * 0.150,
                ),
              ),

              // RegisterButton(SizeConfig.screenHeight, SizeConfig.screenWidth),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(


          height: 63,
          width: 63,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.8, 0.9],
              colors: [Color(0xffC291EE), Color(0xff8E55C1)],
            ),
          ),
        child: FloatingActionButton(

          shape: CircleBorder(),
          heroTag: GestureDetector(
              onTap: () {},
             ),
         /*Color(0xffC291EE)*/
        onPressed: _incrementCounter,


          backgroundColor: Colors.transparent,
               // tooltip: 'Increment',
        child: Icon(Icons.add,color: Colors.white,size: 25,),
        ),
      ),
    ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(left: 10,right: 10,bottom: 20),
        child: BottomNavyBar(
          showInactiveTitle: true,
          selectedIndex: _currentIndex,
          showElevation: true,
       itemPadding: EdgeInsets.symmetric(horizontal: 0),

          itemCornerRadius: 24,
          iconSize: 20,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Padding(
                  padding:  EdgeInsets.all(6.0),
                  child: Icon(Icons.home,color: Colors.black),
                ),
                title: Text('Home'),
                activeBackgroundColor: Colors.white,
                activeTextColor:Colors.black87,
                textAlign: TextAlign.center
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding:  EdgeInsets.all(6.0),
                child: Icon(Icons.search,color: Colors.black),
              ),
              title: Text('Search'),
              activeTextColor:Colors.black87,
              activeBackgroundColor: Colors.white,
              textAlign: TextAlign.center,
            ),

            BottomNavyBarItem(
              icon: Padding(
                padding:  EdgeInsets.all(6.0),
                child:Image(
                    image: AssetImage('assets/images/like.png'),color: Colors.black,height: 18,),
              ),
              title: Text(
                'Favorite',
              ),
              activeTextColor:Colors.black,
              textAlign: TextAlign.center,
              activeBackgroundColor: Colors.white,
            ),
            BottomNavyBarItem(
              icon: Padding(
                padding:  EdgeInsets.all(6.0),
                child: Icon(Icons.settings,color: Colors.black),
              ),
              title: Text('Settings'),

              activeTextColor:Colors.black87,
              activeBackgroundColor: Colors.white,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  Widget getAddMainHeadingLayout(double parentHeight, double parentWidth) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          onDoubleTap: () {},
          child: Padding(
            padding: EdgeInsets.only(left: parentWidth * .02),
            child: Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.04),
              child: Image(
                image: AssetImage('assets/images/sidebar.png'),
                height: parentHeight * 0.05,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: parentHeight * 0.06),
              child: Text(
                "    Hi,Aaysha",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left: parentWidth * 0.03),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/location.png'),
                    height: parentHeight * 0.017,
                  ),
                  Text(
                    "  Park Street, Kolkata, 700021",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                        fontFamily: 'Poppins_Medium',
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: parentWidth * .29),
          child: Padding(
            padding: EdgeInsets.only(top: parentHeight * 0.04),
            child: Image(
              image: AssetImage('assets/images/notification.png'),
              height: parentHeight * 0.025,
            ),
          ),
        ),
      ],
    );
  }

  Widget HomeSearchBar(double parentHeight, double parentWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * .05,
              top: SizeConfig.screenHeight * 0.03),
          child: Container(
            height: SizeConfig.screenHeight * .068,
            width: parentWidth - (SizeConfig.screenWidth * .23),
            child: Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: parentHeight * 0.0,
                        left: parentWidth * 0.0,
                        right: parentWidth * 0.04),
                    child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              spreadRadius: 0,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                              color: Colors.black26)
                        ]),
                        child: TextFormField(
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            controller: searchController,
                            focusNode: _searchFocus,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Image(
                                    image:
                                    AssetImage("assets/images/search.png"),
                                    height: SizeConfig.screenWidth * 0.07,
                                  )),
                              hintText: "Search Product/Service",
                              hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                                color: CommonColor.SearchBar,
                                fontWeight: FontWeight.w300,
                              ),
                              contentPadding: EdgeInsets.only(
                                left: parentWidth * 0.04,
                              ),
                              /*    hintStyle: TextStyle(
                                fontFamily: "Roboto_Regular",
                                color: Color(0xff7D7B7B),
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                // color: CommonColor.DIVIDER_COLOR,
                              ),*/
                              fillColor: Color(0xfffbf3f3),
                              hoverColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12, width: 1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ))),
                  ),
                ),

              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            /* _controller.nextPage(
          duration:  Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );*/
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: parentHeight * 0.02, right: parentWidth * 0.02),
            child: PhysicalShape(
              color: Color(0xff61A5A9),
              shadowColor: Colors.grey.shade300,
              elevation: 10,
              clipper: ShapeBorderClipper(shape: CircleBorder()),
              child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 9,
                          spreadRadius: 1,
                          offset: Offset(4, 2)),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.9],
                      colors: [
                        Color(0xff31D1FC),
                        Color(0xffA5E9FD),
                      ],
                    ),
                    /*   border: Border.all(
                        width: 1, color: CommonColor.APP_BAR_COLOR),*/ //Border.
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Image(
                    image: AssetImage('assets/images/filter.png'),
                    height: parentHeight * 0.1,
                  )),
            ),
          ),
        )
      ],
    );
  }

  Widget sliderData(double parentHeight, double parentWidth) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: images.length,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              initialPage: 1,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .22,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              autoPlay: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            itemBuilder: (BuildContext context, int itemIndex, int index1) {
              final img = images.isNotEmpty
                  ? NetworkImage(images[index1])
                  : NetworkImage("");

              return Container(
                  margin: EdgeInsets.all(16),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.17,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 0,
                        blurRadius: 1,
                        offset: const Offset(4, 4),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(-2, 0),
                      ),
                      BoxShadow(
                        color: Colors.grey.shade50,
                        offset: const Offset(1, 0),
                      )
                    ],
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (int i = 0; i < images.length; i++)

              currentIndex == i ?
              Container(
                width: 25,
                height: 7,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff6a83da),
                        Color(0xff665365B7),
                      ]


                  ),
                ),) : Container(
                width: 7,
                height: 7,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(

                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff7F9ED4),
                          Color(0xff999999),
                        ]


                    ),
                    shape: BoxShape.circle),)
          ],
        ),
      ],
    );
  }

  Widget AddPostButton(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(left: parentWidth * 0.55,right: parentWidth*0.05,top: parentHeight*0.02),
      child: Container(

        //alignment: Alignment.,
        height: parentHeight * 0.05,
width: parentWidth*0.2,
        decoration: BoxDecoration(

          border: Border.all(
              width: 0.5, color: CommonColor.Blue),
          borderRadius: BorderRadius.all(
            Radius.circular(10),

          ),

        ), child: Center(child: Text("Post Add +", style: TextStyle(
        fontFamily: "Roboto_Medium",
        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
        color: Color(0xff3684F0),
        fontWeight: FontWeight.w300,
      ),)),
      ),
    );
  }
}