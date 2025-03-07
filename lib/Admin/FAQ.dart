import 'package:anything/ResponseModule/getCatFAQ.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:anything/ResponseModule/getCatFAQ.dart' as FAQs;
import 'package:anything/ResponseModule/getSubCatagories.dart' as Categories;

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
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
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: SizeConfig.screenHeight * 0.58,
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: filteredItemss.isEmpty ? Center(child: Text("No data available")): ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: filteredItemss.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedCategoryId ==
                            filteredItemss[index].category!.name) {
                          selectedCategoryId = null;
                        } else {
                          selectedCategoryId =
                              filteredItemss[index].category!.name;
                        }
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
                            Padding(
                              padding: EdgeInsets.only(
                                left: 2,
                              ),
                              child: Container(
                                height: 42,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(9.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: SizeConfig.screenHeight * 0.35,
                                          child: Text(
                                            filteredItemss[index]
                                                .category!
                                                .name
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "okra_Medium",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: selectedCategoryId ==
                                                  filteredItemss[index]
                                                      .category!
                                                      .name
                                              ? Image(
                                                  image: AssetImage(
                                                      'assets/images/minus.png'),
                                                  height: 15,
                                                  color: Color(0xfff44343),
                                                )
                                              : Image(
                                                  image: AssetImage(
                                                      'assets/images/add.png'),
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
                            if (selectedCategoryId ==
                                filteredItemss[index].category!.name)
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 7.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 12, right: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: filteredItemss[index]
                                            .questions
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, questionIndex) {
                                      var question = filteredItemss[index]
                                          .questions![questionIndex];
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (selectedName == filteredItemss[index].questions![questionIndex].title) {
                                                  selectedName = null;
                                                } else {
                                                  selectedName = filteredItemss[index].questions![questionIndex].title;
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: SizeConfig.screenHeight * 0.37,
                                                    child: Text(
                                                      filteredItemss[index].questions![questionIndex].title ?? '',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 2),
                                                    child: selectedName == filteredItemss[index].questions![questionIndex].title
                                                        ? Icon(Icons.keyboard_arrow_up, size: 25, color: Color(0xfff44343))
                                                        : Icon(Icons.keyboard_arrow_down, size: 25, color: Color(0xfff44343)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          if (selectedName == filteredItemss[index].questions![questionIndex].title)
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: HtmlWidget(
                                                filteredItemss[index].questions![questionIndex].description ?? '',
                                                onTapUrl: (String? url) async {
                                                  if (url != null && await canLaunchUrl(Uri.parse(url))) {
                                                    await launchUrl(Uri.parse(url));
                                                    return true;
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                                                onLoadingBuilder: (context, element, loadingProgress) =>
                                                    Center(child: CircularProgressIndicator()),
                                                renderMode: RenderMode.column,
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                                                  fontFamily: 'Poppins_Regular',
                                                ),
                                              ),
                                            ),
                                          Divider(),
                                        ],
                                      );

                                    },
                                  ),
                                ),
                              ),
                          ],
                        )),
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
        widget.onContactUsTap();
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

/*

HtmlWidget(
widget.htmlText,
onTapUrl: (String? url) async {
if (await canLaunchUrl(Uri.parse(url!))) {
await launchUrl(Uri.parse(url));
return true;
} else {
throw 'Could not launch $url';
}
},
onErrorBuilder: (context, element, error) =>
Text('$element error: $error'),
onLoadingBuilder: (context, element, loadingProgress) =>
showCircularProgress(
true, Theme.of(context).primaryColor),
renderMode: RenderMode.column,
textStyle: TextStyle(
color: Colors.black,
fontSize: SizeConfig.blockSizeHorizontal * 4.0,
fontFamily: 'Poppins_Regular'),
),
),
),
)*/
