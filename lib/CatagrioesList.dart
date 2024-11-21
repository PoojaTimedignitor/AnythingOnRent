import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
class CatagriesList extends StatefulWidget {
  const CatagriesList({super.key});

  @override
  State<CatagriesList> createState() => _CatagriesListState();
}

class _CatagriesListState extends State<CatagriesList> {
  final List<String> items = [
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
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(items);
    // Initially display all items
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.96,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
                height: SizeConfig.screenHeight*0.9,

                child: AllCatagriesList(SizeConfig.screenHeight,SizeConfig.screenWidth))
          ],
        ),
      ),
    );
  }

 Widget AllCatagriesList(double parentheight,double parentWidth){
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Set the width of the bottom sheet
        child: Padding(
          padding:  EdgeInsets.only(top: parentheight*0.07),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search bar to filter items
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (query) {
                  setState(() {
                    filteredItems = items
                        .where((item) =>
                        item.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                  });
                },
              ),
              SizedBox(height: 10),
              // ListView to show filtered items
              Expanded(
                child:


                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child:  filteredItems.isNotEmpty
                      ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      crossAxisSpacing: 11.0, // Space between columns
                      mainAxisSpacing: 1.0, // Space between rows
                      childAspectRatio: 1,
                      // Aspect ratio of each grid item
                    ),
                    itemCount: filteredItems.length,
                    // Total number of items
                    itemBuilder: (context, index) {
                      String categoryName = filteredItems[index];
                      int productCount = productCountList[categoryName] ?? 0;
                      return GestureDetector(
                        onTap: (){
                          Navigator.pop(context, filteredItems [index]);
                        },
                        child: Container(
                          // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          margin: EdgeInsets.only(
                              left: 0.0, right: 5.0, top: 10.0, bottom: 10.0),
                          //  height: SizeConfig.screenHeight * 0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff9584D6), width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment
                                      .center, // Center aligns items in the stack
                                  children: [
                                    // Container for the background

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

                                      width: 45,
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
                                  filteredItems [index],
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
                )






                /*ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredItems[index]),
                      onTap: () {
                        Navigator.pop(context, filteredItems[index]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You selected: ${filteredItems[index]}'),
                          ),
                        );
                      },
                    );
                  },
                )
                    : Center(child: Text('No items found')),*/
              )
            ],
          ),
        ),
      ),
    );
 }
}
