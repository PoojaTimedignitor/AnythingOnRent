import 'package:anything/Common_File/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'Common_File/common_color.dart';
import 'ResponseModule/getAllCityResponseModel.dart';
import 'model/dio_client.dart';

class CreateCity extends StatefulWidget {
  const CreateCity({super.key});

  @override
  State<CreateCity> createState() => _CreateCityState();
}

class _CreateCityState extends State<CreateCity> {
  final List<String> cityName = [
    "Mumbai",
    "Pune",
    "Nashik",
    "Aurangabad",
    "Nagpur",
    "Dhule",
    "Jalgaon",
    "Nanded",
    "Latur",
    "Solapur"
  ];

  final List<String> CityImage = [
    'assets/images/mumbai.png',
    'assets/images/pune.png',
    'assets/images/nashik.png',
    'assets/images/aurangabad.png',
    'assets/images/nagpur.png',
    'assets/images/dhule.png',
    'assets/images/jalgav.png',
    'assets/images/nanded.png',
    'assets/images/latur.png',
    'assets/images/solapur.png',
  ];

  List<String> filteredItems = [];
  List<String> city = [];
  bool isSearchingData = false;
  String searchQuery = "";
  bool isLoading = true;

  @override
  void initState() {
    print("ggggg");
      fetchCity();
    super.initState();

  }

  void fetchCity() async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllCity();
      var jsonList = getAllCityResponse.fromJson(response);
      setState(() {
        city = jsonList.data ?? [];
        filteredItems = List.from(city);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading in case of error
      });
      print("Error fetching city: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.96,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            AllCityList(SizeConfig.screenHeight, SizeConfig.screenWidth),
            // MainCityData will be the only part that scrolls
            Expanded(child: MainCityData(SizeConfig.screenHeight, SizeConfig.screenWidth)),
          ],
        ),
      ),
    );
  }

  Widget AllCityList(double parentheight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(top: 13),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9, // Set the width of the bottom sheet
          child: Column(
            children: [
              // Search bar to filter items
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Center(
                      child: !isSearchingData
                          ? Text(
                        "Popular City",
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
                              filteredItems = city
                                  .where((item) => item
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
                        setState(() {
                          isSearchingData = !isSearchingData;
                          if (!isSearchingData) {
                            filteredItems = city;
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
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget MainCityData(double parentHeight, double parentWidth) {
    return filteredItems.isNotEmpty
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // GridView inside a SizedBox to ensure it has constraints
          SizedBox(
            height: 370, // Ensure GridView has a fixed height
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 50.0,
                  childAspectRatio: 1,
                ),
                itemCount: cityName.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, cityName[index].toString());
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 3.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            CityImage[index],
                            color: Color(0xff6EC6F9),
                            width: 42,
                          ),
                          Container(
                            width: 120,
                            margin: EdgeInsets.only(bottom: 5),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                cityName[index],
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ListView to show filtered items
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Padding(
                        padding:  EdgeInsets.only(left: 10),
                        child: Text(
                          filteredItems[index].toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      height: SizeConfig.screenHeight * 0.0005,
                      color: CommonColor.SearchBar,
                    ),

                  ],
                );


              },
            ),
          ),
        ],
      ),
    )
        : Column(
      children: [
        Icon(
          Icons.search_sharp,
          color: CommonColor.noResult,
          size: 50,
        ),
        Text(
          "No results found",
          style: TextStyle(
            color: CommonColor.Black,
            fontFamily: "Roboto_Regular",
            fontSize: SizeConfig.blockSizeHorizontal * 4.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: SizeConfig.screenWidth * 0.6,
          child: Text(
            "We couldn't find what you searched for. Try searching again.",
            style: TextStyle(
              color: CommonColor.gray,
              fontFamily: "Roboto_Regular",
              fontSize: SizeConfig.blockSizeHorizontal * 3.3,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

}
