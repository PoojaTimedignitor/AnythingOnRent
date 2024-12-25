import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/ResponseModule/getAllProductList.dart';
import 'package:anything/model/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'Common_File/common_color.dart';

import 'dart:ui' as ui;
import 'dart:ui';

import 'DetailScreen.dart';
import 'MyBehavior.dart';
import 'ResponseModule/getAllProductList.dart';
import 'ResponseModule/getAllProductList.dart';
import 'ResponseModule/getAllProductList.dart';
import 'ff.dart';

class AllProductList extends StatefulWidget {

  const AllProductList({super.key});

  @override
  State<AllProductList> createState() => _AllProductListState();
}

class _AllProductListState extends State<AllProductList> {



  List<Products> filteredItems = [];
  bool isLoading = true;
  bool isSearchingData = false;
  List<Products> items = [];
  List<Images> imagesList = [];
  int currentIndex = 0;
  bool isPagination = true;
  int page = 1;
  int totalCount = 0;

  final List<String> Price = [
    "11,400",
    "500",
    "345",
    "5000",
  ];
  final List<String> Labels = [
    "/Per Hour",
    "/Per Day",
    "/Per Week",
    "/Per Month"
  ];

  @override
  void initState() {
    fetchProductsList(page);
print("hgfhdgf");
    super.initState();




  }



  void fetchProductsList(int page) async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllProductList();
      var jsonList = getAllProductList.fromJson(response);
      setState(() {
     /*   items = jsonList.Products ?? [];*/

        items = jsonList.products ?? [];



        filteredItems = List.from(items);
        totalCount =  items.length;

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("loder $isLoading");
    }
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 2));
    filteredItems.clear();
    page = 1;
    isPagination = true;
    fetchProductsList(page);
    print("Data has been refreshed!");
    /*  page = 1;
      isPagination = true;
      getInternetCheck(page);
      */
    //  callGetReplyComment(page);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 210,
                  decoration: BoxDecoration(
                    color: Color(0xffffe6e3),
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.screenHeight * 0.03,
                          left: SizeConfig.screenWidth * 0.05),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back)),
                          Expanded(
                            child: Center(
                              child: !isSearchingData
                                  ? Text(
                                      "All Product List",
                                      style: TextStyle(
                                        fontFamily: "Montserrat-Medium",
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.5,
                                        color: CommonColor.TextBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.only(left: 14),
                                      child: TextField(
                                        onChanged: (String query) {
                                          setState(() {
                                            filteredItems = items
                                                .where((item) =>
                                                    item.name != null &&
                                                    item.name!
                                                        .toLowerCase()
                                                        .contains(query
                                                            .toLowerCase()))
                                                .toList();
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Search...",
                                          border: InputBorder.none,
                                        ),
                                        autofocus: true,
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(13.0),
                            child: GestureDetector(
                              onTap: () {
                                print("list...$filteredItems");
                                setState(() {
                                  isSearchingData = !isSearchingData;
                                  if (!isSearchingData) {
                                    filteredItems = items;
                                  }
                                });
                              },
                              child: Icon(
                                isSearchingData
                                    ? Icons.close
                                    : Icons.search_rounded,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.screenHeight * 0.0005,
                      color: CommonColor.SearchBar,
                    ),
                    GestureDetector(
                      onTap: () {
                        /*Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlinkitAnimationApp(
          )),
      );*/
                      },
                      child: Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Container(
                          height: 100,
                          width: 600,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 14, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BorderPage(borderState: 0.8)),
                                        );
                                      },
                                      child: Text(
                                        "Accessories",
                                        style: TextStyle(
                                          //   color: Color(0xffFE7F64),
                                          color: Colors.black,
                                          letterSpacing: 0.7,
                                          fontFamily: "okra_Medium",
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  4.7,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Container(
                                      height: 30,
                                      width: 170,
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/sort.png'),
                                            height: 20,
                                            color: Color(0xffFE7F64),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "Sort",
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontFamily: "okra_Medium",
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.8,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Image(
                                            image: AssetImage(
                                                'assets/images/filter.png'),
                                            height: 20,
                                            color: Color(0xffFE7F64),
                                          ),
                                          SizedBox(width: 9),
                                          Text(
                                            "Filters",
                                            style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.0,
                                              fontFamily: "okra_Medium",
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.8,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: SizeConfig.screenHeight * 0.018,
                                      color: Color(0xffFE7F64),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: 120,
                                        child: Text(
                                          " Mumbai",
                                          style: TextStyle(
                                            color: Color(0xffFE7F64),
                                            letterSpacing: 0.0,
                                            fontFamily: "okra_Medium",
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    3.4,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text("1 - $totalCount Results",
                                    style: TextStyle(
                                      color: Colors.grey[500]!,
                                      fontFamily: "okra_Regular",
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 3.5,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //appbar dynamic Create

            //search box
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(shrinkWrap: true, children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Divider()),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                            child: Text(
                          "ALL PRODUCT LIST CHOOSE YOUR LOCATION",
                          style: TextStyle(color: Colors.grey[500]!),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  isLoading
                      ? Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: Image(
                              image: AssetImage("assets/images/logo.gif"),
                              height: SizeConfig.screenHeight * 0.13),
                        ))
                      : filteredItems.isNotEmpty
                          ? ListView.builder(
                              itemCount: filteredItems.length,
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {


                                final product = filteredItems[index];
                                final productImages = product.images ?? [];
                                final rent = product.rent;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20), // Add gap here
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 600),
                                          reverseTransitionDuration:
                                              Duration(milliseconds: 400),
                                          pageBuilder: (_, __, ___) =>
                                              DetailScreen(product: product),
                                          transitionsBuilder: (_, animation,
                                              secondaryAnimation, child) {
                                            var curve = Curves.easeInOut;
                                            var tween = Tween(
                                                    begin: 0.0, end: 1.0)
                                                .chain(CurveTween(curve: curve));
                                            return FadeTransition(
                                              opacity: animation.drive(tween),
                                              child: ScaleTransition(
                                                scale: animation.drive(tween),
                                                child: child,
                                              ),
                                            );
                                          },
                                        ),
                                      );

                                      //  Navigator.pop(context, filteredItems [index].name.toString());
                                    },
                                    child: Stack(
                                      children: [

                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 12),
                                          child: Container(
                                            height: 210,
                                            decoration: BoxDecoration(
                                              color: Color(0xfff2f3fb),
                                              borderRadius: BorderRadius.circular(10),
                                              /*border: Border.all(
                                                  color: CommonColor.grayText,
                                                  width: 0.3),*/
                                            ),
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Hero(
                                                      tag: product.sId
                                                          .toString(), // Use the same tag here
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.all(2),
                                                            height:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    0.15,

                                                            child: Center(
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                                child: Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      image: productImages
                                                                              .isNotEmpty
                                                                          ? NetworkImage(
                                                                              productImages[0].url ??
                                                                                  "") // Display the first image
                                                                          : AssetImage(
                                                                                  'assets/images/placeholder.png')
                                                                              as ImageProvider, // Placeholder image
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          /*CarouselSlider.builder(
                                                     itemCount: productImages.length,
                                                     options: CarouselOptions(
                                                       onPageChanged: (index, reason) {
                                                         setState(() {
                                                           currentIndex = index;
                                                         });
                                                       },
                                                       initialPage: 1,
                                                       height: MediaQuery.of(context).size.height * .19,
                                                       viewportFraction: 1.0,
                                                       enableInfiniteScroll: false,
                                                       autoPlay: true,
                                                       enlargeStrategy: CenterPageEnlargeStrategy.height,
                                                     ),
                                                     itemBuilder: (BuildContext context, int itemIndex, int index1) {
                                                       print("object....${productImages}");
                                                       final img = productImages.isNotEmpty
                                                           ? NetworkImage( productImages[itemIndex].url ?? "")
                                                           : NetworkImage("");

                                                       return Container(
                                                           margin: EdgeInsets.all(0),
                                                           height: MediaQuery.of(context).size.height * 0.17,
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
                                                     }),*/

                                                          /*  Row  (
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                     for (int i = 0; i < productImages.length; i++)
                                                       currentIndex == i
                                                           ? Container(
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
                                                               ]),
                                                         ),
                                                       )
                                                           : Container(
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
                                                                 ]),
                                                             shape: BoxShape.circle),
                                                       )
                                                   ],
                                                 ),*/
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 12,
                                                          top: 2),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            height:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    0.045,
                                                            decoration: BoxDecoration(

                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(10),
                                                            ),
                                                            child:

                                                            Row(children: [
                                                              Expanded(
                                                                child: CarouselSlider
                                                                    .builder(
                                                                        itemCount:
                                                                    items.length,
                                                                        options:
                                                                            CarouselOptions(
                                                                          onPageChanged:
                                                                              (index,
                                                                                  reason) {
                                                                            setState(
                                                                                () {
                                                                              currentIndex =
                                                                                  index;
                                                                            });
                                                                          },
                                                                          initialPage:
                                                                              1,
                                                                          height: MediaQuery.of(context)
                                                                                  .size
                                                                                  .height *
                                                                              .19,
                                                                          viewportFraction:
                                                                              1.0,
                                                                          enableInfiniteScroll:
                                                                              false,
                                                                          autoPlay:
                                                                              true,
                                                                          enlargeStrategy:
                                                                              CenterPageEnlargeStrategy
                                                                                  .height,
                                                                        ),
                                                                        itemBuilder: (BuildContext
                                                                                context,
                                                                            int itemIndex,
                                                                            int index1) {

                                                                          final Rent? rent = items[itemIndex].rent;

                                                                          String priceDisplay = '';
                                                                          if (rent != null) {

                                                                            if (rent.perDay != null && rent.perDay! > 0) {
                                                                              priceDisplay = "₹${rent.perDay} (Day)";
                                                                            } else if (rent.perWeek != null && rent.perWeek! > 0) {
                                                                              priceDisplay = "₹${rent.perWeek} (Week)";
                                                                            } else if (rent.perMonth != null && rent.perMonth! > 0) {
                                                                              priceDisplay = "₹${rent.perMonth} (Month)";
                                                                            } else if (rent.perHour != null && rent.perHour! > 0) {
                                                                              priceDisplay = "₹${rent.perHour} (Hour)";
                                                                            } else {
                                                                              priceDisplay = "Price Not Available";
                                                                            }
                                                                          }
                                                                          return Padding(
                                                                            padding:  EdgeInsets.only(top: 7,left: 7),
                                                                            child: Row(
                                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  priceDisplay,
                                                                                  style:
                                                                                      TextStyle(
                                                                                    color:
                                                                                        CommonColor.Black,
                                                                                        fontFamily: "okra_Bold",
                                                                                    fontSize:
                                                                                        19,
                                                                                    fontWeight:
                                                                                        FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                    width:
                                                                                        2),
                                                                              /*  Padding(
                                                                                  padding: const EdgeInsets.all(5.0),
                                                                                  child: Text(
                                                                                    Labels[
                                                                                        index],
                                                                                    style:
                                                                                        TextStyle(

                                                                                          letterSpacing: 0.2,
                                                                                          fontFamily: "okra_Regular",
                                                                                          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                                                                          fontWeight: FontWeight.w400,

                                                                                    ),
                                                                                  ),
                                                                                ),*/
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                              ),

                                                              Padding(
                                                                padding:  EdgeInsets.only(right: 15,top: 3),
                                                                child: Column(
                                                                  children: [

                                                                    Text(
                                                                      "${currentIndex + 1}/${Price.length}", // Display current slide index and total slides



                                                                      style: TextStyle(
                                                                        color: Color(0xffFE7F64),
                                                                        letterSpacing: 0.0,
                                                                        fontFamily: "okra_Medium",
                                                                        fontSize:
                                                                        SizeConfig.blockSizeHorizontal *
                                                                            3.3,
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),

                                                                    Row(

                                                                      children: [
                                                                        for (int i = 0; i < Price.length; i++)
                                                                          if (i >= currentIndex - 1 && i <= currentIndex + 1)
                                                                          currentIndex == i
                                                                              ? Container(
                                                                                  width: 10,
                                                                                  height: 6,
                                                                                  margin: EdgeInsets
                                                                                      .all(
                                                                                          1),
                                                                                  decoration:
                                                                                      BoxDecoration(
                                                                                    borderRadius:
                                                                                        BorderRadius.circular(10),
                                                                                    gradient: LinearGradient(
                                                                                        begin:
                                                                                            Alignment.topRight,
                                                                                        end: Alignment.bottomLeft,
                                                                                        colors: [
                                                                                          Color(0xffFE7F64),
                                                                                          Color(
                                                                                              0xfffdc4b2),
                                                                                        ]),
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  width: 6,
                                                                                  height: 6,
                                                                                  margin: EdgeInsets
                                                                                      .all(
                                                                                          2),
                                                                                  decoration: BoxDecoration(
                                                                                      gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [
                                                                                        Color(0xffb1b1b1),
                                                                                        Color(
                                                                                            0xffb1b1b1),
                                                                                      ]),
                                                                                      shape: BoxShape.circle),
                                                                                )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                          ),
                                                          /* Text(
                                                   filteredItems[index].name.toString(),
                                                  style: TextStyle(
                                                     color: Colors.black,
                                                     letterSpacing: 0.2,
                                                     fontFamily: "okra_Medium",
                                                     fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                                                     fontWeight: FontWeight.w400,
                                                   ),overflow: TextOverflow.ellipsis,
                                                 ),*/

                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.location_on,
                                                                size: SizeConfig
                                                                        .screenHeight *
                                                                    0.017,
                                                                color:
                                                                    Color(0xff3684F0),
                                                              ),
                                                              Flexible(
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 250,

                                                                      child: Text(
                                                                        ' MG ROAD, PUNE',
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color(
                                                                              0xff3684F0),

                                                                          fontFamily:
                                                                              "okra_Regular",
                                                                          fontSize:
                                                                              SizeConfig.blockSizeHorizontal *
                                                                                  2.8,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .w400,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        maxLines: 1,
                                                                      ),
                                                                    ),
                                                                   /* Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              left:
                                                                                  16),
                                                                      child:
                                                                          Container(
                                                                        width: SizeConfig
                                                                                .screenWidth *
                                                                            0.14,
                                                                        height: 22,
                                                                        decoration: BoxDecoration(
                                                                            color: Color(0xff5E9C73),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                                    10)),

                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .spaceEvenly,
                                                                          children: [
                                                                            Icon(
                                                                              Icons
                                                                                  .star,
                                                                              size: SizeConfig.screenHeight *
                                                                                  0.018,
                                                                              color: CommonColor
                                                                                  .white,
                                                                            ),
                                                                            Text(
                                                                              filteredItems[index]
                                                                                  .rating
                                                                                  .toString(),
                                                                              style:
                                                                                  TextStyle(
                                                                                fontFamily:
                                                                                    "Roboto-Regular",
                                                                                fontSize:
                                                                                    SizeConfig.blockSizeHorizontal * 3.1,
                                                                                color:
                                                                                    CommonColor.white,
                                                                                fontWeight:
                                                                                    FontWeight.w400,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),*/
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),


                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Container(

                                                                width: 240,
                                                                height: 14,
                                                                child: Text(" Honda Shine 125cc 2024 Model",style: TextStyle(

                                                                  letterSpacing: 0.2,

                                                                    color: Colors.grey[500]!,
                                                                    fontFamily: "okra_Regular",
                                                                  fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                                                  fontWeight: FontWeight.w400),),
                                                              ),
                                                              Padding(
                                                                padding:  EdgeInsets.only(right: 10),
                                                                child: Align(
                                                                  alignment: Alignment.topRight,
                                                                  child: Container(

                                                                    width: 80,
                                                                    height: 20,
                                                                    child: Center(
                                                                      child: Text("20 Nov 2024",style: TextStyle(
                                                                        color: Colors.grey[500]!,
                                                                        letterSpacing: 0.2,
                                                                        fontFamily: "okra_Medium",
                                                                        fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                                                        fontWeight: FontWeight.w400,),),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Positioned(
                                                    right: 10,
                                                    top: 10,
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(50),
                                                        border: Border.all(
                                                            color:
                                                                CommonColor.grayText,
                                                            width: 0.5),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1), // Shadow color
                                                            blurRadius:
                                                                5, // Shadow blur
                                                            offset: Offset(0,
                                                                2), // Shadow position (x, y)
                                                          ),
                                                        ],
                                                      ),
                                                      child: IconButton(
                                                        color: Colors.white,
                                                        onPressed: () {},
                                                        icon: Icon(
                                                          Icons.bookmark_border_sharp,
                                                          color: Colors.pink,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    )),
                                                Positioned(
                                                    left: 10,
                                                    top: 90,
                                                    child: Container(
                                                      width: 230,
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(0.3),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(5),
                                                        child: Text(
                                                          filteredItems[index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            letterSpacing: 0.2,
                                                            fontFamily:
                                                                "okra_Medium",
                                                            fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                3.7,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    )),
                                               /* Positioned(
                                                    right: 10,
                                                    top: 94,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  10)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(5),
                                                        child: Center(
                                                          child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.end,
                                                            // mainAxisAlignment: MainAxisAlignment.s,
                                                              children: [
                                                                Icon(
                                                                  Icons.location_on,
                                                                  size: SizeConfig
                                                                          .screenHeight *
                                                                      0.019,
                                                                  color: Colors.white,
                                                                ),
                                                                Text(
                                                                  '1.2 Km   ',
                                                                  style: TextStyle(
                                                                    fontFamily:
                                                                        "Montserrat-Regular",
                                                                    fontSize: SizeConfig
                                                                            .blockSizeHorizontal *
                                                                        2.8,
                                                                    color:
                                                                        Colors.white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                    ))*/
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: 80),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_sharp,
                                    color: CommonColor.noResult,
                                    size: 50,
                                  ),
                                  Text("No results found",
                                      style: TextStyle(
                                        color: CommonColor.Black,
                                        fontFamily: "Roboto_Regular",
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                4.0,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  SizedBox(height: 10),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.6,
                                    child: Text(
                                      "We couldn't find what you searched for try searching again",
                                      style: TextStyle(
                                        color: CommonColor.gray,
                                        fontFamily: "Roboto_Regular",
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.3,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );


  }


}
