import 'package:anything/Common_File/SizeConfig.dart';
import 'package:flutter/material.dart';

import 'Common_File/common_color.dart';
import 'ResponseModule/getAllCatList.dart';
import 'createProduct.dart';
import 'model/dio_client.dart';
class CatProductService extends StatefulWidget {
  final Function(String) onChanged;
  final String categoryId;

  const CatProductService({super.key, required this.onChanged, required this.categoryId});

  @override
  State<CatProductService> createState() => _CatProductServiceState();
}

class _CatProductServiceState extends State<CatProductService> {
  int selectedIndex = 0;

  List<Data> items = [];

  final List<String> catagriesImage = [
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
    'assets/images/property.png',
    'assets/images/party.png',
    'assets/images/home.png',
    'assets/images/weddingdress.png',
    'assets/images/art.png',
    'assets/images/other.png',
  ];

  List<Data> filteredItems = [];

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
      body:Column(
        children: [
          DataServiceProduct(SizeConfig.screenHeight,SizeConfig.screenWidth)
        ],
      )
    );
  }


  Widget DataServiceProduct(double parentHeight,double parentWidth){
    return  Container(
      height: SizeConfig.screenHeight * 0.93,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 40,left: 10,right: 10),
            child: Container(
              padding:  EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Color(0xffe1e8fd),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, // Align buttons to ends
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 58, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: selectedIndex != 1
                            ? LinearGradient(
                          colors: [Color(0xff632883), Color(0xff8d42a3)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )
                            : null,
                        color: selectedIndex == 1
                            ? Colors.transparent
                            : null,
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Text(
                        "Product",
                        style: TextStyle(
                            fontFamily: "Montserrat-BoldItalic",
                            color: selectedIndex == 0
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 58, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: selectedIndex == 1
                            ? LinearGradient(
                          colors: [Color(0xfff12935), Color(0xffFF5963)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        )
                            : null,
                        color: selectedIndex != 1
                            ? Colors.transparent
                            : null,
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Text(
                        "Service",
                        style: TextStyle(
                            color: selectedIndex == 1
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat-BoldItalic",
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(

              alignment: Alignment.center,
              child: selectedIndex == 0
                  ?  Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: filteredItems.isNotEmpty
                        ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            print("Category Name: ${filteredItems[index].name.toString()}");
                            widget.onChanged(
                                selectedCategoryId); // Pass categoryId to parent widget
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewProduct(lat: '', long: '', ProductAddress: '', BusinessOfficeAddress:'', categoryName: filteredItems[index].name.toString(),  imagePath: filteredItems[index].bannerImage != null &&
                                            filteredItems[index].bannerImage!.isNotEmpty
                                            ? filteredItems[index].bannerImage!
                                            : 'assets/images/estione.png',
                                        )));


                            /*Navigator.pop(context,
                                filteredItems[index].name.toString());*/
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 8.0,
                                right: 5.0,
                                top: 14.0,
                                bottom: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15))),
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
                        );
                      },
                    )
                        : Column(
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
                  ))
                  : Text(
                "Zepto Super Saver Content",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
