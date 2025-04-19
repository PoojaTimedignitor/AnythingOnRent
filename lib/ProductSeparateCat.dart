import 'dart:io';

import 'package:anything/ResponseModule/getAllCatList.dart';


import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

import 'MyBehavior.dart';


import 'model/dio_client.dart';

class CatagriesList extends StatefulWidget {
  final Function(String) onChanged;
  final String categoryId;

  const CatagriesList(
      {super.key, required this.onChanged, required this.categoryId});

  @override
  State<CatagriesList> createState() => _CatagriesListState();
}

class _CatagriesListState extends State<CatagriesList> {
  List<Data> items = [];

  final List<String> catagriesImage = [
    'assets/images/Pet_World.png',
    'assets/images/Cosmetics_Image.png',
    'assets/images/Sports_Image.png',
    'assets/images/Stationary_Books.png',
    'assets/images/Fashion_Image.png',
    'assets/images/Wedding_Dresses.png',
    'assets/images/Event_Material.png',
    'assets/images/Electricals_Image.png',
    'assets/images/Pet_World.png',
    'assets/images/Pet_World.png',
    'assets/images/Pet_World.png',
    'assets/images/Automobiles_Image.png',
    'assets/images/Pet_World.png',
    'assets/images/Pet_World.png',
    'assets/images/Pet_World.png',
    'assets/images/Pet_World.png',
    'assets/images/Agriculture_Image.png',
    'assets/images/Pet_World.png',
    'assets/images/Pet_World.png',
  ];

  List<Data> filteredItems = [];
  File imageFile = File('/storage/emulated/0/Download/sample_image.jpg');
  bool isLoading = true;
  bool isSearchingData = false;

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  void fetchCategories() async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllCat();
      var jsonList = GetAllCategoriesList.fromJson(response);
      setState(() {

        items = jsonList.data ?? [];

        filteredItems = List.from(items);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching categories: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: SizeConfig.screenHeight * 0.93,
          decoration: const BoxDecoration(
            color: Color(0xffF5F6FB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: [
                isLoading
                    ? Padding(
                        padding:
                            EdgeInsets.only(top: SizeConfig.screenHeight * 0.4),
                        child: Image(
                            image: AssetImage("assets/images/logo.gif"),
                            height: SizeConfig.screenHeight * 0.15),
                      )
                    : SizedBox(
                        height: SizeConfig.screenHeight * 0.9,
                        child: AllCatagriesList(
                            SizeConfig.screenHeight, SizeConfig.screenWidth))
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget AllCatagriesList(double parentheight, double parentWidth) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            //padding: EdgeInsets.only(top: parentheight * 0.05),
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search bar to filter items
                Row(
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
                                "Product Categories",
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
                                  decoration: const InputDecoration(
                                    hintText: "Search...",
                                    border: InputBorder.none,
                                  ),
                                  autofocus: true,
                                ),
                              ),
                      ),
                    ),
                    GestureDetector(
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
                    )
                  ],
                ),  SizedBox(height: 15),
                Container(
                  height: SizeConfig.screenHeight * 0.0005,
                  color: CommonColor.SearchBar,
                ),
      
      
                // ListView to show filtered items
      
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(0.06),
                  child: filteredItems.isNotEmpty
                      ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns
                            crossAxisSpacing: 11.0, // Space between columns
                            mainAxisSpacing: 1.0, // Space between rows
                            childAspectRatio: 1,
                          ),
                          itemCount: filteredItems.length,
                          // Total number of items
                          itemBuilder: (context, index) {
                            print(
                                "ddddd  ${filteredItems[index].name.toString()}");
      
                            /* String categoryName = filteredItems[index];
                        int productCount = productCountList[categoryName] ?? 0;*/
                            return GestureDetector(
                              onTap: () {
                                String selectedCategoryId =
                                    filteredItems[index].sId.toString();
                                print(
                                    "Selected Category ID: $selectedCategoryId");
      
                                widget.onChanged(
                                    selectedCategoryId);
                                Navigator.pop(context,
                                    filteredItems[index].name.toString());
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      catagriesImage[index],
                                    scale: 10,
                                    //  width: 35,
                                    ),
                                  ),
                                  Container(
                                 //   width: 120,
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        filteredItems[index].name.toString(),
                                        style: TextStyle(
                                          color: CommonColor.Black,
                                          fontFamily: "Roboto_Regular",
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.2,
                                          //fontWeight: FontWeight.w400,
                                          fontWeight: FontWeight.w500,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Column(
                          children: [
                            const Icon(
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}






/// All Category container
     /*
      Container(
                              margin: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 5.0,
                                  top: 14.0,
                                  bottom: 10.0),
                              // decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius:
                              //         BorderRadius.all(Radius.circular(15))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      catagriesImage[index],
                                      width: 35,
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        filteredItems[index].name.toString(),
                                        style: TextStyle(
                                          color: CommonColor.Black,
                                          fontFamily: "Roboto_Regular",
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.2,
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
     */


/*
 'assets/images/fashion.png',
    'assets/images/furniture.png',
    'assets/images/vehicle.png',
    'assets/images/electronics.png',
    'assets/images/cosmatics.png',
    'assets/images/stationery.png',
    'assets/images/books.png',
    'assets/images/sports.png',
    'assets/images/agriculture.png',
    'assets/images/health.png',
    //'assets/images/property.png',
    // 'assets/images/party.png',
    // 'assets/images/home.png',
    // 'assets/images/weddingdress.png',
    // 'assets/images/art.png',
    // 'assets/images/other.png',
    // 'assets/images/other.png',
    // 'assets/images/other.png',
*/