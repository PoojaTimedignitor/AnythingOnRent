import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

class PopularCatagoriesData extends StatefulWidget {
  const PopularCatagoriesData({super.key});

  @override
  State<PopularCatagoriesData> createState() => _PopularCatagoriesDataState();
}

class _PopularCatagoriesDataState extends State<PopularCatagoriesData> {
  List<String> catagriesItemList = [
    "Vehicle",
    "Fashion",
    "Home Appliances",
    "Event",
    "Furniture",
    "Party Bus",
    "Car",
    "Camera",
    "Bike",
    "Sports Equipment",
    "Clothing",
    "Electronics",
    "Kitchenware",
    "Office Equipment",
  ];
  final List<String> catagriesImage = [
    'assets/images/cattwo.png',
    'assets/images/catthree.png',
    'assets/images/catfour.png',
    'assets/images/catone.png',
    'assets/images/catthree.png',
    'assets/images/cattwo.png',
    'assets/images/catone.png',
    'assets/images/cattwo.png',
    'assets/images/catthree.png',
    'assets/images/catthree.png',
    'assets/images/catthree.png',
    'assets/images/catfour.png',
    'assets/images/catfour.png',
    'assets/images/cattwo.png',
    'assets/images/cattwo.png'
  ];
  final Map<String, int> productCountList = {
    "Vehicle": 12,
    "Fashion": 8,
    "Home Appliances": 15,
    "Event": 5,
    "Furniture": 20,
    "Party Bus": 3,
    "Camera": 6,
    "Bike": 7,
    "Sports Equipment": 11,
    "Clothing": 9,
    "Electronics": 14,
    "Kitchenware": 13,
    "Office Equipment": 8,
  };

  List<String> searchFilteredList = [];
  bool isSearchingData = false;
  String searchQuery = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    searchFilteredList = catagriesItemList;
  }

  void searchUpdateMethod(String query) {
    setState(() {
      searchQuery = query;
      searchFilteredList = catagriesItemList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
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
                : TextField(
                    onChanged: searchUpdateMethod,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                  )),
        actions: [
          Padding(
            padding: EdgeInsets.all(13.0),
            child: GestureDetector(
              onTap: () {
                print("list...$searchUpdateMethod");
                setState(() {
                  isSearchingData = !isSearchingData;
                  if (!isSearchingData) {
                    searchFilteredList = catagriesItemList;
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
      body: Column(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.0005,
            color: CommonColor.SearchBar,
          ),
          SizedBox(height: 40),
         searchFilteredList .isEmpty ?

         Column(
           children: [
             const Icon(Icons.search_sharp,  color: CommonColor.noResult,size: 50,),
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
                 color: Colors.grey,
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
         ):

         Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 8.0, // Space between columns
                  mainAxisSpacing: 1.0, // Space between rows
                  childAspectRatio: 1,
                  // Aspect ratio of each grid item
                ),
                itemCount: searchFilteredList.length,
                // Total number of items
                itemBuilder: (context, index) {
                  String categoryName = searchFilteredList[index];
                  int productCount = productCountList[categoryName] ?? 0;
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    margin: EdgeInsets.only(
                        left: 0.0, right: 5.0, top: 10.0, bottom: 10.0),
                    //  height: SizeConfig.screenHeight * 0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 0.9),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment
                                .center, // Center aligns items in the stack
                            children: [
                              // Container for the background
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 8, top: 11.0, bottom: 8),
                                // Set a width for the container
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: CommonColor
                                        .Containerss // Use a placeholder color for debugging
                                    ),
                              ),

                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 23,
                                    width: 23,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 0,
                                              blurRadius: 6,
                                              offset: Offset(0, 1),
                                              color: Colors.black12)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                        color: Colors
                                            .white // Use a placeholder color for debugging
                                        ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "$productCount",
                                        style: TextStyle(
                                          color: CommonColor.Black,
                                          fontFamily: "Roboto_Regular",
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.2,
                                          fontWeight: FontWeight.w400,

                                        ), textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Image on top
                              Image.asset(
                                catagriesImage[index],
                                height: 98,
                                width: 55,
                              ),
                              // Text below the image
                            ],
                          ),
                        ),
                        Container(
                          width: 120,
                          margin: EdgeInsets.only(bottom: 5),
                          // bottom: 10, // Position the text at the bottom
                          child: Text(
                            searchFilteredList[index],
                            style: TextStyle(
                              color: CommonColor.Black,
                              fontFamily: "Roboto_Regular",
                              fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
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
