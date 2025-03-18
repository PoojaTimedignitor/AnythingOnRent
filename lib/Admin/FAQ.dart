import 'package:anything/ResponseModule/getCatFAQ.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:anything/ResponseModule/getCatFAQ.dart' as FAQs;
import 'package:anything/ResponseModule/getSubCatagories.dart' as Categories;

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../Common_File/new_responsive_helper.dart';
import '../MyBehavior.dart';
import '../ResponseModule/getCatFAQ.dart';
import '../model/dio_client.dart';

class FAQ extends StatefulWidget {
  final VoidCallback onContactUsTap;

  const FAQ({super.key, required this.onContactUsTap});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {

  List<Data> itemss = [];
  List<Data> filteredItemss = [];
  bool isLoading = true;
  bool isOpen = false;
  String? selectedCategoryId;
  String? selectedName;

  void fetchKnowledgement() async {
    try {
      Map<String, dynamic> response = await ApiClients().getCatFAQ();

      var jsonList = getCatFaqResponse.fromJson(response);

      setState(() {
        itemss = jsonList.data?.toList() ?? [];
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

  void _handleLinkTap(String? url) {
    if (url != null) {
      _launchURL(url);
    }
  }


  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    fetchKnowledgement();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);        /// new change

    return Scaffold(
      // backgroundColor: Color(0xffF5F6FB),
      body:
      ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          FAQQuestions(responsive),SizedBox(height: 20,),
          Align(
            alignment: Alignment.bottomRight,
            child: AddContactUsButton(
                responsive ),
          )
        ],
      ),

    );
  }


  Widget FAQQuestions(ResponsiveHelper responsive) {
    return Padding(
      padding: responsive.getPadding(vertical: 4.0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: responsive.width(responsive.isMobile ? 187.5 : responsive.isTablet ? 300 : 400),
              child: Text(
                "Frequently Asked Questions?",
                style: TextStyle(
                  fontFamily: "okra_extrabold",
                  fontSize: responsive.fontSize(20),
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),

            SizedBox(height: responsive.height(10)),

            Container(
              width: responsive.width(responsive.isMobile ? 600 : responsive.isTablet ? 1024 : 1200),
              child: Text(
                "Find questions and answers related to the design system, purchases, updates, and support.",
                style: TextStyle(
                  color: CommonColor.grayText,
                  fontFamily: "Montserrat-Medium",
                  fontSize: responsive.fontSize(12),
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: responsive.height(20)),

            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredItemss.length,
              itemBuilder: (context, index) {
                return FAQItem(index, responsive);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget FAQItem(int index, ResponsiveHelper responsive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryId = selectedCategoryId == filteredItemss[index].category!.name ? null : filteredItemss[index].category!.name;
        });
      },
      child: Container(
        margin: responsive.getMargin(vertical: 10),
        width: responsive.width(responsive.isMobile ? 600 : responsive.isTablet ? 1024 : 1200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsive.width(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.15),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: responsive.getPadding(all: 4),
              child: Container(
                height: responsive.height(responsive.isMobile ? 40 : responsive.isTablet ? 60 : 65),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(responsive.width(10)),
                ),
                child: Center(
                  child: Padding(
                    padding: responsive.getPadding(all: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: responsive.width(responsive.isMobile ? 250 : responsive.isTablet ? 250 : 260),
                          child: Text(
                            filteredItemss[index].category!.name.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              fontSize: responsive.fontSize(16),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: responsive.getPadding(horizontal: 10),
                          child: selectedCategoryId == filteredItemss[index].category!.name
                              ? Image.asset(
                            'assets/images/minus.png',
                            height: responsive.height(responsive.isMobile ? 12 : responsive.isTablet ? 20 : 22),
                            color: Colors.deepPurple,
                          )
                              : Image.asset(
                            'assets/images/add.png',
                            height: responsive.height(responsive.isMobile ? 12 : responsive.isTablet ? 20 : 22),
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (selectedCategoryId == filteredItemss[index].category!.name)
              Container(
                margin: responsive.getMargin(vertical: 7),
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: responsive.getPadding(horizontal: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredItemss[index].questions?.length ?? 0,
                    itemBuilder: (context, questionIndex) {
                      var question = filteredItemss[index].questions![questionIndex];
                      return FAQQuestionItem(question, responsive);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget FAQQuestionItem(var question, ResponsiveHelper responsive) {
    return Padding(
      padding: responsive.getPadding(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedName = selectedName == question.title ? null : question.title;
              });
            },
            child: Padding(
              padding: responsive.getPadding(all: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: responsive.width(responsive.isMobile ? 250 : responsive.isTablet ? 260 : 270),
                    child: Text(
                      question.title ?? '',
                      style: TextStyle(
                        fontSize: responsive.fontSize(15),
                        color: Colors.indigo.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    selectedName == question.title ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: responsive.width(20),
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ),

          if (selectedName == question.title)
            Container(
              margin: responsive.getMargin(vertical: 10),
              padding: responsive.getPadding(all: 12),
              child: HtmlWidget(
                question.description ?? '',
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: responsive.fontSize(14),
                  fontFamily: 'Poppins_Regular',
                ),
              ),
            ),

          Divider(color: Colors.blueGrey.shade300, thickness: 1),
        ],
      ),
    );
  }


  // Widget AddContactUsButton(double parentHeight, double parentWidth) {

  Widget AddContactUsButton(ResponsiveHelper responsive) {

    return GestureDetector(
      onTap: () {
        widget.onContactUsTap();
      },
      child: Padding(
        padding: responsive.getPadding(vertical: 0.0),                            /// new changes
        child: Container(
          height: responsive.height(responsive.isMobile ? 60 : responsive.isTablet ? 70 : 80),                        /// new changes
          // height: parentHeight * 0.09,
          width: responsive.width(responsive.isMobile ? 200 : responsive.isTablet ? 250 : 300),                       /// new changes
          decoration: const BoxDecoration(
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
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Do You still need aur help?",
                    style: TextStyle(
                      fontFamily: "Montserrat-BoldItalic",
                      //fontSize: parentWidth * 0.034,
                      fontSize: responsive.fontSize(13),                           /// new changes
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 5),

                  Container(
                    // height: parentHeight* 0.035,
                    height: responsive.height(responsive.isMobile ? 20 : responsive.isTablet ? 30 : 40),                        /// new changes
                    //  width: parentWidth * 0.3,
                    width: responsive.width(responsive.isMobile ? 100 : responsive.isTablet ? 200 : 300),                       /// new changes
                    decoration: const BoxDecoration(
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
                          fontSize: responsive.fontSize(13),                                 /// new changes
                          // fontSize: parentWidth * 0.032,
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