import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../DetailScreen.dart';
import '../MyBehavior.dart';
import '../ResponseModule/getAllProductList.dart';
import '../model/dio_client.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool isSearchingData = false;
  List<Products> filteredItems = [];
  List<Products> items = [];
  bool isLoading = true;
  int currentIndex = 0;
  int page = 1;
  bool isPagination = true;

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
        items = jsonList.products ?? [];

        filteredItems = List.from(items);

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
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.04,
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
                        "Add To Cart",
                        style: TextStyle(
                          fontFamily: "Montserrat-Medium",
                          fontSize: SizeConfig.blockSizeHorizontal * 4.5,
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
                                      .contains(query.toLowerCase()))
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
                        isSearchingData ? Icons.close : Icons.search_rounded,
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
            MainCollectionData(SizeConfig.screenHeight, SizeConfig.screenWidth)
          ],
        ));
  }

  Widget MainCollectionData(double parentHeight, double parentWidth) {
    return Expanded(
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
                      "TO CREATE ALL ADD TO CART PRODUCT LIST",
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
                padding:
                const EdgeInsets.only(bottom: 8), // Add gap here
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
                          var tween = Tween(begin: 0.0, end: 1.0)
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                       // color: Color(0xfff8f8ff),
                        border: Border.all(  color: CommonColor.SearchBar,width: 0.3 ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag: product.sId
                                .toString(), // Use the same tag here
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Ensure text aligns at the top
                                children: [
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start, // Align everything to the start
                                        children: [

                                          Container(



                                        // Set width for each item
                                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.topRight,
                                              colors: [Color(0xffededff), Color(0xffffffff)],
                                            ),

                                            borderRadius: BorderRadius.circular(10)),
                                            child: Padding(
                                              padding:  EdgeInsets.only(left: 5),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(top: 8,left: 2),
                                                    child: Text(
                                                      filteredItems[index]
                                                          .name
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: CommonColor
                                                            .Black,
                                                        fontFamily:
                                                        "okra_Medium",
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                      ),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(height: 1),
                                                  Container(
                                                    height: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height *
                                                        0.033,
                                                    child:
                                                    CarouselSlider
                                                        .builder(
                                                      itemCount:
                                                      items.length,
                                                      options:
                                                      CarouselOptions(
                                                        initialPage: 1,
                                                        height: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.10,
                                                        viewportFraction:
                                                        1.0,
                                                        enableInfiniteScroll:
                                                        false,
                                                        autoPlay: true,
                                                        enlargeStrategy:
                                                        CenterPageEnlargeStrategy
                                                            .height,
                                                      ),
                                                      itemBuilder: (BuildContext
                                                      context,
                                                          int itemIndex,
                                                          int index1) {
                                                        final Rent?
                                                        rent =
                                                            items[itemIndex]
                                                                .rent;
                                                        String priceDisplay = rent !=
                                                            null
                                                            ? rent.perDay !=
                                                            null &&
                                                            rent.perDay! >
                                                                0
                                                            ? "₹${rent.perDay} (Day)"
                                                            : "Price Not Available"
                                                            : "Price Not Available";

                                                        return Align(
                                                          alignment:
                                                          Alignment
                                                              .topLeft, // Ensures alignment starts from top-left
                                                          child: Text(
                                                            priceDisplay,
                                                            style:
                                                            TextStyle(
                                                              color: Color(
                                                                  0xffFE7F64),
                                                              letterSpacing:
                                                              0.2,
                                                              fontFamily:
                                                              "okra_Medium",
                                                              fontSize:
                                                              SizeConfig.blockSizeHorizontal *
                                                                  3.5,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            )
                                          ),




                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10,top: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [


                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on,
                                                      size: SizeConfig
                                                          .screenHeight *
                                                          0.017,
                                                      color: Color(
                                                          0xff3684F0),
                                                    ),
                                                    Flexible(
                                                      child:
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
                                                                3.0,
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
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width:120,
                                                      child: Text(
                                                        "Honda Shine 125cc 2024 Model",
                                                        style: TextStyle(
                                                          letterSpacing: 0.2,
                                                          color: Colors.grey[500]!,
                                                          fontFamily: "okra_Regular",
                                                          fontSize: SizeConfig.blockSizeHorizontal * 3.0,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        overflow: TextOverflow.ellipsis, // Truncate overflowed text
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.topRight,
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Text(
                                                          " 20 Nov 2024  ",
                                                          style: TextStyle(
                                                            color: Colors.grey[500]!,
                                                            letterSpacing: 0.2,
                                                            fontFamily: "okra_Bold",
                                                            fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                          textAlign: TextAlign.right, // Align text to the right
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  /*  Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, right: 5),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/more.png'),
                                                height: 15,
                                              ),
                                            ),*/


                                  Stack(
                                    children: [

                                      Padding(
                                        padding:  EdgeInsets.only(top: 63,right: 10),
                                        child: Container(

                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.10,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.23,
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/home.jpeg'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: 60,top: 67),
                                        child: Container(
                                          height: 26,
                                          width: 26,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(50),
                                            border: Border.all(color: CommonColor.grayText, width: 0.5),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.bookmark_border_sharp,
                                              color: Colors.pink,
                                              size: 15,
                                            ),
                                          ),
                                        ),
                                      )


                                    ],
                                  ),


                                ]),
                          )
                        ],
                      ),
                    ),
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
                      fontSize: SizeConfig.blockSizeHorizontal * 4.0,
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
                      fontSize: SizeConfig.blockSizeHorizontal * 3.3,
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
    );
  }
}
