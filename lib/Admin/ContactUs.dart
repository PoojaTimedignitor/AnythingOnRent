import 'package:anything/ResponseModule/getCatFAQ.dart';
import 'package:anything/ResponseModule/getContactUsCatResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../MyBehavior.dart';

import '../model/dio_client.dart';
import 'ContactUsQuestions.dart';

class ContactUsPage extends StatefulWidget {
  final VoidCallback onContactQuationTap;

  const ContactUsPage({super.key, required this.onContactQuationTap});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  List<ExistingSupportCategories> itemss = [];
  List<ExistingSupportCategories> filteredItemss = [];
  bool isLoading = true;
  bool isOpen = false;
  String? selectedCategoryId;
  String updatedTexts = "";
  String updatedDescription = "";
  TextEditingController productNameController = TextEditingController();


  void fetchContactUs() async {
    try {
      Map<String, dynamic> response = await ApiClients().getContactUsQuations();

      var jsonList = getContactUsCatResponse.fromJson(response);

      setState(() {
        itemss = jsonList.existingSupportCategories ?? [];
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
    fetchContactUs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      body: Column(
        children: [
          FAQQuations(SizeConfig.screenHeight, SizeConfig.screenWidth),
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
              "Let's Talk?",
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
              "Tell us about your issues so we can help you more quickly. ",
              style: TextStyle(
                color: CommonColor.Black,
                fontFamily: "Montserrat-Medium",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () async {
              final String? result =
                  await showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  isScrollControlled: true,
                  isDismissible: true,
                  builder: (BuildContext bc) {
                    return ContactUs();
                  });

              if (result != null) {
                setState(() {
                  updatedTexts = result;
                  updatedDescription = result;
                });
              }
            },
            child: Container(
                height: SizeConfig.screenHeight * 0.09,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Image(
                          image: AssetImage('assets/images/questionmark.png'),
                          height: 20,
                        )),
                    Container(
                      width: SizeConfig.screenHeight * 0.3,
                      child: Text(
                        "Ask a Question Here",
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
                        child: Image(
                          image: AssetImage('assets/images/downarrow.png'),
                          height: 35,
                          color: Color(0xfff44343),
                        )),
                  ],
                )

                /*Text("Ask a Question Here"),*/

/*
              ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: filteredItemss.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
               setState(() {
                          if (selectedCategoryId ==
                              filteredItemss[index].sId) {
                            selectedCategoryId = null;
                          } else {
                            selectedCategoryId =
                                filteredItemss[index].sId;
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
                              padding: EdgeInsets.only(left: 2, right: 2),
                              child: Container(
                                height: 42,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: SizeConfig.screenHeight * 0.37,
                                          child: Text(
                                            filteredItemss[index]
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
                                          child:  Image(
                                            image: AssetImage(
                                                'assets/images/downarrow.png'),
                                            height: 35,
                                            color: Color(0xfff44343),
                                          )

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
                                  padding:  EdgeInsets.only(left: 12,right: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: filteredItemss[index].questions?.length ?? 0,
                                    itemBuilder: (context, questionIndex) {
                                      var question = filteredItemss[index].questions![questionIndex];
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 8),
                                          Text(
                                            question.title.toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            question.description.toString(),
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),*/
                ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Container(
               height:100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (updatedTexts),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "okra_Medium",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xfffff4f2),
                            borderRadius: BorderRadius.circular(5)),
                        width: 500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (updatedDescription) + " jsfgg jfghdf ajhgfhaf ajhgdfagf afhah",
                            style: TextStyle(
                              color: CommonColor.grayText,
                              fontFamily: "Montserrat-Medium",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),

              SizedBox(height: 34),
              Text(
                "    Product Name",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "okra_Medium",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 10, right: 10, top: 10),
                child: TextFormField(
                  //  enabled: selectedCategory != null,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    keyboardType: TextInputType.text,
                    controller: productNameController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText:
                      'Ex.HD Camera (black & white)',
                      contentPadding: EdgeInsets.all(10.0),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xffa1a1a1),
                        fontSize:
                        SizeConfig.blockSizeHorizontal *
                            3.5,
                      ),
                      fillColor: Color(0xffF5F6FB),
                      hoverColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                          BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffD9D9D9),
                            width: 1),
                        borderRadius:
                        BorderRadius.circular(10.0),
                      ),
                    )),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
