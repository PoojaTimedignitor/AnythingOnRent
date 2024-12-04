import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/model/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'Common_File/common_color.dart';

import 'MyBehavior.dart';
import 'ResponseModule/getAllProductList.dart';

class AllProductList extends StatefulWidget {
  const AllProductList({super.key});

  @override
  State<AllProductList> createState() => _AllProductListState();
}

class _AllProductListState extends State<AllProductList> {



  List<Data1> filteredItems = [];
  bool isLoading = true;
  bool isSearchingData = false;
  List<Data1> items = [];
  List<Images> imagesList = [];
  int currentIndex = 0;

  Future<void> fetchImages(BuildContext context) async {


  }

  @override
  void initState() {
    fetchSlideImages();
   // fetchCategories();
    super.initState();

    // Initially display all items
  }

  void fetchSlideImages() async {
    try {
      // Fetch data from API
      Map<String, dynamic> response = await ApiClients().getAllProductList();

      // Parse the response into getAllProductList object
      var jsonList = getAllProductList.fromJson(response);

      // Extract Images objects from the response
      List<Images> fetchedImages = [];
      for (var data in jsonList.data1 ?? []) {
        if (data.images != null) {
          for (var image in data.images!) {
            fetchedImages.add(image); // Add Images object to the list
          }
        }
      }

      setState(() {
        items = jsonList.data1 ?? [];

        filteredItems = List.from(items);
        isLoading = false;
        imagesList = fetchedImages; // Update the imagesList
        isLoading = false; // Stop loading
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching images: $e");
    }
  }
  void fetchCategories() async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllProductList();
      var jsonList = getAllProductList.fromJson(response);
      setState(() {
        items = jsonList.data1 ?? [];

        filteredItems = List.from(items);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading in case of error
      });
      print("Error fetching categories: $e");
    }
  }


  @override
  Widget build(BuildContext context) {


    final List<String> imageUrls = [
      "https://cdn.bikedekho.com/processedimages/oben/oben-electric-bike/source/oben-electric-bike65f1355fd3e07.jpg",
      "https://pune.accordequips.com/images/products/15ccb1ae241836.png",
      "https://5.imimg.com/data5/NK/AW/GLADMIN-33559172/marriage-hall.jpg",
      "https://content.jdmagicbox.com/comp/ernakulam/x9/0484px484.x484.230124125915.a8x9/catalogue/zorucci-premium-rentals-edapally-ernakulam-bridal-wear-on-rent-mbd4a48fzz.jpg",
      "https://content.jdmagicbox.com/v2/comp/pune/n2/020pxx20.xx20.230311064244.s4n2/catalogue/shree-laxmi-caterers-somwar-peth-pune-caterers-yhxuxzy1t9.jpg",
    ];


   // ScreenUtil.init(context, designSize: const Size(360, 690));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [


            Padding(
              padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.03,left: SizeConfig.screenWidth*0.05),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  Expanded(
                    child: Center(
                      child: !isSearchingData
                          ? Text(
                        "Popular Categories",
                        style: TextStyle(
                          fontFamily: "Montserrat-Medium",
                          fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                          color: CommonColor.TextBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                          : Padding(
                        padding:  EdgeInsets.only(left: 14),
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

            //appbar dynamic Create



            //search box
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView(
                  children: [



                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider()),
                          SizedBox(
                            width: 10,
                          ),
                          Center(child: Text("ALL PRODUCT LIST CHOOSE YOUR LOCATION",style: TextStyle(color: Colors.grey[500]!),)),
                          SizedBox(
                            width: 10,

                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                    ),
                    filteredItems.isNotEmpty? ListView.builder(
                      itemCount: filteredItems.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical, itemBuilder: (BuildContext context, int index) {

                      print( "ddddddd  ${filteredItems[index].name.toString()}");

                      return GestureDetector(
                        onTap: (){
                          Navigator.pop(context, filteredItems [index].name.toString());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal:15,vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xfff1f2fd),
                                borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: CommonColor.grayText,
                                  width: 0.3),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        CarouselSlider.builder(
                                            itemCount: imagesList.length,
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
                                              print("object    ${imagesList}");
                                              final img = imagesList.isNotEmpty
                                                  ? NetworkImage(imagesList[index1].url ?? '')
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
                                            }),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            for (int i = 0; i < imageUrls.length; i++)
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
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            filteredItems[index].name.toString(),
                                           style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 0.2,
                                              fontFamily: "okra_medium",
                                              fontSize: SizeConfig.blockSizeHorizontal * 4.1,
                                              fontWeight: FontWeight.w500,
                                            ),overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: SizeConfig.screenHeight *
                                                    0.019,
                                                color: Color(0xff3684F0),
                                              ),
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 250,

                                                      child: Text(
                                                        ' Park Street,pune banner 20023',
                                                        style: TextStyle(
                                                          color: Color(0xff3684F0),
                                                          letterSpacing: 0.0,
                                                          fontFamily: "okra_Regular",
                                                          fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                                                          fontWeight: FontWeight.w400,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 12),
                                                      child: Container(
                                                        width: SizeConfig.screenWidth *
                                                            0.14,
                                                        height: 22,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                10)),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              size: SizeConfig
                                                                  .screenHeight *
                                                                  0.018,
                                                              color: CommonColor.Black,
                                                            ),
                                                            Text(
                                                              filteredItems[index].rating.toString(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                "Roboto-Regular",
                                                                fontSize: SizeConfig
                                                                    .blockSizeHorizontal *
                                                                    3.1,
                                                                color:
                                                                CommonColor.Black,
                                                                fontWeight:
                                                                FontWeight.w400,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),


                                          //Text("Kothi Compound ,Rajkot"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                    right: 10,
                                    top: 10,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: CommonColor.grayText,width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black
                                                .withOpacity(0.1), // Shadow color
                                            blurRadius: 5, // Shadow blur
                                            offset:
                                            Offset(0, 2), // Shadow position (x, y)
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: (){},icon: Icon(Icons.favorite_outline,color: Colors.pink,size: 20,),),
                                    )
                                ),
                                Positioned(
                                    left: 10,
                                    top: 118,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Center(child:Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
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
                                                      2.9,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                                overflow: TextOverflow
                                                    .ellipsis,
                                              ),
                                            ]),),
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },

                    ):  Column(
                      children: [
                        Icon(Icons.search_sharp,  color: CommonColor.noResult,size: 50,),
                        Text("No results found",  style: TextStyle(
                          color: CommonColor.Black,
                          fontFamily: "Roboto_Regular",
                          fontSize:
                          SizeConfig.blockSizeHorizontal *
                              4.0,
                          fontWeight: FontWeight.w600,

                        )),SizedBox(height: 10) ,Container(
                          width: SizeConfig.screenWidth*0.6,
                          child: Text("We couldn't find what you searched for try searching again",  style: TextStyle(
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
                  ]
                ),
              ),
            ),


          ],
        ),
      ),
    );





    /*Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              "assets/images/backk.png",
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 120),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/images/backkone.png",
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight * 0.15,
                left: SizeConfig.screenWidth * 0.015,
                right: SizeConfig.screenWidth * 0.015),
            child: Container(
                height: SizeConfig.screenHeight * 0.8,
                width: SizeConfig.screenWidth * 0.98,
                *//*decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border:
                        Border.all(color: CommonColor.grayText, width: 0.5)),*//*
                child: AllProduct(
                    SizeConfig.screenHeight, SizeConfig.screenWidth)),
          ),
          // Main content

          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.08),
            child: Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/images/allpro.png",
                height: SizeConfig.screenHeight * 0.13,
              ),
            ),
          ),
        ],
      ),
    );*/
  }



  /*Widget AllProduct(double parentHeight, double parentWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text widget at the top
        Padding(
          padding: EdgeInsets.only(top: parentHeight * 0.01),
          child: Text(
            "  All Product List",
            style: TextStyle(
              fontFamily: "Montserrat-Medium",
              fontSize: SizeConfig.blockSizeHorizontal * 4.1,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // GridView.builder below the text
        Expanded(
          child: Container(
            padding:
                EdgeInsets.only(top: 02.0, bottom: 16.0, left: 5, right: 5),
            // Set height to fit the horizontal list
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10, // Define the number of items
                itemBuilder: (context, index) {
                  return Container(
                    width: parentWidth * 0.55,
                    height: parentHeight * 0.18,

                    // Set width for each item
                    margin: EdgeInsets.symmetric(vertical: 9.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    *//*  border:
                          Border.all(color: CommonColor.grayText, width: 0.1),*//*
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff535353).withOpacity(0.2),
                            blurRadius: 1,
                            spreadRadius: 0,
                            offset: Offset(0, 0)),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: SizeConfig.screenHeight * 0.16,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CommonColor.Black, width: 0.1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                child: AnotherCarousel(
                                  images: const [
                                    NetworkImage(
                                        "https://sb.kaleidousercontent.com/67418/960x550/3e324c0328/individuals-removed.png"),
                                    NetworkImage(
                                        "https://media.istockphoto.com/id/507832549/photo/couple-standing-on-balcony-of-modern-house.jpg?s=2048x2048&w=is&k=20&c=7ooit4W_g24NDUGnLDWs9Dlh0F8T6dRbtX8RBBgQiuE="),
                                    NetworkImage(
                                        "https://media.istockphoto.com/id/1436217023/photo/exterior-of-a-blue-suburban-home.jpg?s=2048x2048&w=is&k=20&c=Z9Wc1NpUagwfdZbtHCyVEF9JnLXDIsPyIrw48-UXFb0="),
                                    // we have display image from netwrok as well
                                    NetworkImage(
                                        "https://media.istockphoto.com/id/1132628728/photo/couple-in-front-of-residential-home-smiling.jpg?s=2048x2048&w=is&k=20&c=wqxgUhQQAqthoi-h80nHksGOhklcUywyrkCDwXPXxEc=")
                                  ],
                                  dotSize: 6,
                                  dotSpacing: 10,
                                  dotColor: Colors.white70,
                                  dotIncreasedColor: Colors.black45,
                                  indicatorBgPadding: 5.0,
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: SizeConfig.screenWidth * 0.52,
                           //   color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' HD Camera (black & white) dfgdf',
                                        style: TextStyle(
                                          fontFamily: "Montserrat-Regular",
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.8,
                                          color: CommonColor.Black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 7),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size:
                                                SizeConfig.screenHeight * 0.02,
                                            color: Color(0xff3684F0),
                                          ),
                                          Flexible(
                                            child: Text(
                                              ' Park Street,pune banner 20023',
                                              style: TextStyle(
                                                fontFamily:
                                                    "Montserrat-Regular",
                                                fontSize: SizeConfig
                                                        .blockSizeHorizontal *
                                                    3.0,
                                                color: Color(0xff3684F0),
                                                fontWeight: FontWeight.w400,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 28,
                                        decoration:
                                        BoxDecoration(
                                          color: Color(
                                              0xfff8e8e8),
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              4),
                                        ),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.end,                           // mainAxisAlignment: MainAxisAlignment.s,
                                            children: [

                                              Text(
                                                '   Posted By:  ',
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  "Montserrat-Regular",
                                                  fontSize:
                                                  SizeConfig.blockSizeHorizontal * 2.8,
                                                  color:
                                                  Colors.black87,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Aaysha',
                                                style:
                                                TextStyle(
                                                  fontFamily:
                                                  "Montserrat-Regular",
                                                  fontSize:
                                                  SizeConfig.blockSizeHorizontal * 2.8,
                                                  color:
                                                  Color(0xffC56262),
                                                  fontWeight:
                                                  FontWeight.w400,
                                                ),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                              SizedBox(width: 45),
                                              Container(
                                                width: SizeConfig.screenWidth *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffffffff),
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        3)),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: SizeConfig
                                                          .screenHeight *
                                                          0.016,
                                                      color: Color(0xffFFB905),
                                                    ),
                                                    Text(
                                                      "  4.5",
                                                      style: TextStyle(
                                                        fontFamily:
                                                        "Roboto-Regular",
                                                        fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                            2.5,
                                                        color:
                                                        CommonColor.Black,
                                                        fontWeight:
                                                        FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ]),
                                      ),
                                      SizedBox(height: 13),
                                      Row(
                                        children: [
                                          // color: Color(0xff3684F0),

                                          Text(
                                            " Share",
                                            style: TextStyle(
                                              color: CommonColor.grayText,
                                              fontFamily: "Roboto_Regular",
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 17),
                                          Image(
                                              image: AssetImage(
                                                  'assets/images/share.png'),
                                              height: 15),


                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }*/





}
