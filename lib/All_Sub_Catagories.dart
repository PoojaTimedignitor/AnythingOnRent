

import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/Common_File/common_color.dart';
import 'package:anything/ResponseModule/getSubCatagories.dart';

import 'package:flutter/material.dart';


import 'MyBehavior.dart';
import 'NewDioClient.dart';


class AllSubCat extends StatefulWidget {
  final String categoryId;

  const AllSubCat({super.key, required this.categoryId});

  @override
  State<AllSubCat> createState() => _AllSubCatState();
}

class _AllSubCatState extends State<AllSubCat> {
  TextEditingController emailController = TextEditingController();
  String? selectedCategory;
  String? selectedCategoryId;
  bool isLoading = true;
  List<SubCategory> filteredItems = [];

  List<dynamic> items = [];
/*
  List<dynamic> filteredItems = [];
*/
  List<dynamic> itemsDynamicFields = [];
  List<dynamic> filteredItemsDynamicFields = [];

/*  List<SubCategory> items = [];*/



  void fetchSubCategories() async {
    try {
      Map<String, dynamic> response = await NewApiClients().NewGetAllSubCat(widget.categoryId);
      var jsonList = GetSubCategoriesResponseModel.fromJson(response);

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
  void initState() {
    fetchSubCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: SizeConfig.screenWidth * .35),
                    child: Container(
                      color: CommonColor.showBottombar.withOpacity(0.2),
                      height: SizeConfig.screenHeight * 0.004,
                      width: SizeConfig.screenHeight * 0.1,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * .1,
                        top: SizeConfig.screenHeight * 0.01),
                    child: Container(
                      padding:
                          EdgeInsets.only(top: SizeConfig.screenHeight * 0.017),
                      child: Icon(
                        Icons.close,
                        size: SizeConfig.screenHeight * .03,
                        color: CommonColor.Black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                "Sub Categories",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w400,
                    color: CommonColor.Black),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.015,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedCategory != null) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "$selectedCategory >>",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                ],
              ],
            ),

            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: isLoading
                    ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Image(
                          image: AssetImage("assets/images/logo.gif"),
                          height: SizeConfig.screenHeight * 0.16),
                    ))
                    : ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    return RadioListTile<String>(
                      activeColor: Color(0xff632883),
                      title: Text(
                        filteredItems[index].name.toString(),
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: "okra_Medium",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: filteredItems[index].name.toString(),
                      groupValue: selectedCategory,
                      onChanged: (String? value) {
                        setState(() {
                          print("Selected Category Name: ${value}");
                          selectedCategory = value;
                         // selectedCategoryId = filteredItems.firstWhere((item) => item.name == value).id;
                          print("Selected Category ID: $selectedCategoryId");


                          //   selectedCategoryId = filteredItems[index].id.toString();

                          print("subCat $selectedCategoryId");
                        });


                        Navigator.pop(context, value);
                      },
                    );
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
