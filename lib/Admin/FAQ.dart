import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anything/ResponseModule/getCatFAQ.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../MyBehavior.dart';
import '../model/dio_client.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<Knowledgement> itemss = [];
  List<Knowledgement>  filteredItemss = [];
  bool isLoading = true;
   bool isOpen = false;


  void fetchCategories() async {
    try {
      Map<String, dynamic> response = await ApiClients().getCatFAQ();

      var jsonList = getCatFaqResponse.fromJson(response);
      setState(() {
        itemss = jsonList.knowledgement?.toList() ?? [];
        filteredItemss = List.from(itemss);
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
    fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      appBar: AppBar(
        title: Text(
          "Help Center",
          style: TextStyle(
            fontFamily: "Montserrat-Medium",
            fontSize: SizeConfig.blockSizeHorizontal * 4.5,
            color: CommonColor.TextBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FAQQuations(SizeConfig.screenHeight, SizeConfig.screenWidth),
          Align(
              alignment: Alignment.bottomCenter,
              child: AddContactUsButton(
                  SizeConfig.screenHeight, SizeConfig.screenWidth))
        ],
      ),
    );
  }

  Widget FAQQuations(double parentHeight, double parentWidth) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            child: Text(
              "Frequently Asked Questions?",
              style: TextStyle(
                fontFamily: "okra_extrabold",
                fontSize: SizeConfig.blockSizeHorizontal * 5.1,
                color: Colors.black,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 400,
            child: Text(
              "Find questions and answers related to the design system,perches,updates and support. ",
              style: TextStyle(
                color: CommonColor.grayText,
                fontFamily: "Montserrat-Medium",
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2, // Limit to 2 lines
              overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: SizeConfig.screenHeight * 0.58,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: filteredItemss.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isOpen = !isOpen; // Toggle the dropdown state
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 7.0),
                      width: SizeConfig.screenHeight * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          // First container part (text and icon)
                          Padding(
                            padding: EdgeInsets.only(left: 2, right: 2),
                            child: Container(
                              height: 42,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        filteredItemss[index].name.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "okra_Medium",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: isOpen
                                            ? Image(
                                          image: AssetImage('assets/images/minus.png'),
                                          height: 15,
                                          color: Color(0xfff44343),
                                        )
                                            : Image(
                                          image: AssetImage('assets/images/add.png'),
                                          height: 15,
                                          color: Color(0xfff44343),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Second container part (details)
                          if (isOpen)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                 filteredItemss[index].d.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
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


        ],
      ),
    );
  }

  Widget AddContactUsButton(double parentHeight, double parentWidth) {
    return GestureDetector(
      onTap: () {
        print("Create Post button tapped");
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: parentWidth * 0.2,
          right: parentWidth * 0.06,
          top: parentHeight * 0.01,
        ),
        child: Container(
          height: parentHeight * 0.09,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xfff44343),
                Color(0xfffa8b8b),
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Do You still need aur help?",
                    style: TextStyle(
                      fontFamily: "Montserrat-BoldItalic",
                      fontSize: parentWidth * 0.034,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: parentHeight * 0.034,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                          fontFamily: "Montserrat-BoldItalic",
                          fontSize: parentWidth * 0.032,
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
