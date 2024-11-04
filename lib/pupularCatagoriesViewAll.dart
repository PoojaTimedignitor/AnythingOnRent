import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

class PopularCatagoriesData extends StatefulWidget {
  const PopularCatagoriesData({super.key});

  @override
  State<PopularCatagoriesData> createState() => _PopularCatagoriesDataState();
}

class _PopularCatagoriesDataState extends State<PopularCatagoriesData> {
  List<String> CatagriesItemList = [
    "Vehicle",
    "Fashion",
    "Home Appliances",
    "Event",
    "Furniture",
    "Party Bus",
    "Car",
    "Camera",
    "Bike",
    "Clothing"
  ];
  final List<String> CatagriesImage = [
    'assets/images/cattwo.png',
    'assets/images/catthree.png',
    'assets/images/catfour.png',
    'assets/images/catone.png',
    'assets/images/catthree.png',
    'assets/images/cattwo.png',
    'assets/images/catone.png',
    'assets/images/cattwo.png',
    'assets/images/catthree.png',
    'assets/images/catfour.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Popular Categories",
            style: TextStyle(
              fontFamily: "Montserrat-Medium",
              fontSize: SizeConfig.blockSizeHorizontal * 4.5,
              color: CommonColor.TextBlack,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(13.0),
            child: Icon(Icons.search_rounded),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.0005,
            color: CommonColor.SearchBar,
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8.0, // Space between columns
                  mainAxisSpacing: 8.0, // Space between rows
                  childAspectRatio: 1,
                  // Aspect ratio of each grid item
                ),
                itemCount: CatagriesItemList.length, // Total number of items
                itemBuilder: (context, index) {
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    margin: EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
                    //  height: SizeConfig.screenHeight * 0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 0.9),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment
                                .topLeft, // Center aligns items in the stack
                            children: [
                              // Container for the background
                              Container(
                                margin: EdgeInsets.only(
                                    left: 22.0, right: 8, top: 11.0,bottom: 8),
                                // Set a width for the container
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: CommonColor.Containerss // Use a placeholder color for debugging
                                ),
                              ),
                              // Image on top
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 30), // Adjusted padding
                                child: Image.asset(

                                  CatagriesImage[index],
                                  height: 98,
                                  width: 55,
                                ),
                              ),
                              // Text below the image

                            ],
                          ),
                        ), Container(
                          width:120,
                          margin: EdgeInsets.only(
                              bottom: 5),
                         // bottom: 10, // Position the text at the bottom
                          child: Text(
                            CatagriesItemList[index],
                            style: TextStyle(
                              color: CommonColor.Black,
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                              fontWeight: FontWeight.w400,
                            ), overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
