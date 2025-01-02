import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anything/ResponseModule/getCatFAQ.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../ResponseModule/getCatFAQ.dart';
import '../model/dio_client.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {

  List<Knowledgement> itemss = [];
  List<Knowledgement> filteredItemss = [];
  bool isLoading = true;

  void fetchCategories() async {
    try {
      Map<String, dynamic> response = await ApiClients().getCatFAQ();

      var jsonList = getCatFaqResponse.fromJson(response);
      setState(() {
      itemss = jsonList.knowledgement?.toList()  ?? [];
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
      backgroundColor:Color(0xffF5F6FB),
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
    ), body: Column(
children: [
  FAQQuations(SizeConfig.screenHeight,SizeConfig.screenWidth),
  Align(
      alignment: Alignment.bottomCenter,

      child: AddContactUsButton(SizeConfig.screenHeight,SizeConfig.screenWidth))

],
    ),
    );
  }

  Widget FAQQuations (double parentHeight, double parentWidth){
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        width: 250,
        child: Text("Frequently Asked Questions?", style: TextStyle(
      fontFamily: "okra_extrabold",
      fontSize: SizeConfig.blockSizeHorizontal * 5.1,
      color: Colors.black,
      fontWeight: FontWeight.w200,
        ),),
      ),

        SizedBox(height: 10),
        Container(
          width: 400,
          child: Text("Find questions and answers related to the design system,perches,updates and support. ", style: TextStyle(
            color: CommonColor.grayText,
            fontFamily: "Montserrat-Medium",
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
            maxLines: 2, // Limit to 2 lines
            overflow: TextOverflow
                .ellipsis, // Add ellipsis if text overflows
          ),
        ),
        SizedBox(height: 20),



        Container(
          height: SizeConfig.screenHeight*0.5,

          child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: filteredItemss.length, // Define the number of items
              itemBuilder: (context, index) {
                return Column(
                  children: [
                     Padding(
          padding: EdgeInsets.only(left: 2,right: 2),
          child: Container(
            height: 40,
            margin: EdgeInsets.symmetric(
                vertical: 7.0),
            width: SizeConfig.screenHeight*0.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))

            ),child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*Icon(
                    Icons.help_outline, // Icon before the text
                    color: Colors.black,
                    size: 20,
                  ),*/


                  SizedBox(width: 8),
                  Text(
                    filteredItemss[index].name.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                 /* Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),*/
                ],
              )

          ),

          ),
        ),

                    /*Container(
                      height: parentHeight * 0.02,
                      width: parentWidth * 0.2,

                      child: Text(
                        filteredItemss[index].name.toString(),
                        style: TextStyle(
                          letterSpacing: 0.5,
                          color: Colors.black,
                          fontFamily: "Montserrat_Medium",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),

                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),*/
                  ],
                );
              }),
        ),



       /* Padding(
          padding: EdgeInsets.only(left: 2,right: 2),
          child: Container(
            height: 40,
            width: SizeConfig.screenHeight*0.5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))

            ),child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 *//* Icon(
                    Icons.help_outline, // Icon before the text
                    color: Colors.black,
                    size: 20,
                  ),*//*
                  SizedBox(width: 8),
                  Text(
                    " What is an FAQ page?",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                 *//* Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),*//*
                ],
              )

          ),

          ),
        ),*/
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
          left: parentWidth * 0.2, // Adjust padding as needed
          right: parentWidth * 0.06,
          top: parentHeight * 0.02, // Space from bottom edge
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
