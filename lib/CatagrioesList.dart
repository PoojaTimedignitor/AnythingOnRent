import 'package:anything/ResponseModule/getAllCatList.dart';

import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';

import 'model/dio_client.dart';
class CatagriesList extends StatefulWidget {
  const CatagriesList({super.key});

  @override
  State<CatagriesList> createState() => _CatagriesListState();
}

class _CatagriesListState extends State<CatagriesList> {

  List<Data> items = [];



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
    'assets/images/cattwo.png'
  ];

  List<Data> filteredItems = [];
  bool isLoading = true;
  bool isSearchingData = false;


  @override
  void initState() {
    fetchCategories();
    super.initState();

    // Initially display all items
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
        isLoading = false; // Stop loading in case of error
      });
      print("Error fetching categories: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.93,
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
            isLoading
                ? Padding(
                  padding:  EdgeInsets.only(top:SizeConfig.screenHeight*0.4),
                  child: Image(image: AssetImage("assets/images/logo.gif"),height: SizeConfig.screenHeight*0.15),
                ):  SizedBox(
                height: SizeConfig.screenHeight*0.9,

                child: AllCatagriesList(SizeConfig.screenHeight,SizeConfig.screenWidth))
          ],
        ),
      ),
    );
  }

 Widget AllCatagriesList(double parentheight,double parentWidth){

   return   Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Set the width of the bottom sheet
        child: Padding(
          padding:  EdgeInsets.only(top: parentheight*0.03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search bar to filter items
              Row(
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
                              item.categoryName != null &&
                                  item.categoryName!
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
              Container(
                height: SizeConfig.screenHeight * 0.0005,
                color: CommonColor.SearchBar,
              ),

              SizedBox(height: 15),
              // ListView to show filtered items

              Expanded(
                child:


                Padding(
                  padding:  EdgeInsets.all(1.0),
                  child:  filteredItems.isNotEmpty
                      ? GridView.builder  (
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
                      print( "ddddd  ${filteredItems[index].categoryName.toString()}");

                      /* String categoryName = filteredItems[index];
                      int productCount = productCountList[categoryName] ?? 0;*/
                      return GestureDetector(

                        onTap: (){

                          Navigator.pop(context, filteredItems [index].categoryName.toString());
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
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child:  Image.asset(
                                  catagriesImage[index],

                                  width: 45,
                                ),
                              ),
                              Container(

                                width: 120,
                                margin: EdgeInsets.only(bottom: 5),
                                // bottom: 10, // Position the text at the bottom
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    filteredItems[index].categoryName.toString(),
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
                  ):

                  Column(
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
