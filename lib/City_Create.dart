import 'package:anything/Common_File/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'Common_File/common_color.dart';
class CreateCity extends StatefulWidget {
  const CreateCity({super.key});

  @override
  State<CreateCity> createState() => _CreateCityState();
}

class _CreateCityState extends State<CreateCity> {
  final List<String> itemsCity = [
    "Mumbai",
    "Delhi",
    "Bangalore",
    "Pune",
    "Jaipur",
    "Lucknow",
    "Bhopal",
    "Patna",
    "Vadodara",
    "Ghaziabad",
    "Ludhiana",
    "Thāne",
    "Nāsik",
    "Kalyān",
    "Nāgpur",
  ];

  final List<String> CityImage = [
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
    'assets/images/catone.png',
    'assets/images/cattwo.png'
  ];

  List<String> filteredItems = [];
  bool isSearchingData = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredItems = itemsCity;
    // Initially display all items
  }

  void searchUpdateMethod(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = itemsCity
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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

                child: AllCityList(SizeConfig.screenHeight,SizeConfig.screenWidth))
          ],
        ),
      ),
    );
  }
  Widget AllCityList(double parentheight,double parentWidth){
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
                    filteredItems = itemsCity
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


                        return GestureDetector(
                          onTap: (){
                            Navigator.pop(context, filteredItems [index]);                          },
                          child: Container(
                            // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            margin: EdgeInsets.only(
                                left: 0.0, right: 5.0, top: 10.0, bottom: 10.0),
                            //  height: SizeConfig.screenHeight * 0,
                     /*       decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff9584D6), width: 0.5),
                                borderRadius: BorderRadius.all(Radius.circular(10))),*/
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    CityImage[index],

                                    width: 35,
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  margin: EdgeInsets.only(bottom: 5),
                                  // bottom: 10, // Position the text at the bottom
                                  child: Text(
                                    filteredItems [index],
                                    style: TextStyle(
                                      color: Color(0xff675397),

                                      fontFamily: "Poppins-Medium",
                                      fontSize: SizeConfig.blockSizeHorizontal * 3.8,
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
