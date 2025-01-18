import 'package:anything/ResponseModule/getContactUsCatResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import 'package:get_storage/get_storage.dart';

import '../ConstantData/Constant_data.dart';
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
  TextEditingController messageController = TextEditingController();



  void onTextSelected(String result) {
    if (result.isNotEmpty) {
      setState(() {
        updatedTexts = result;
        updatedDescription = "";
        isOpen = true;
      });
    }
  }


  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: SizeConfig.screenHeight *
            0.7, // Adjust this value to position it exactly where you want
        left: 2,
        right: 2,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the snack bar after some time
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

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
      body: FAQQuations(SizeConfig.screenHeight, SizeConfig.screenWidth),
    );
  }

  Widget FAQQuations(double parentHeight, double parentWidth) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        //crossAxisAlignment: CrossAxisAlignment.start,
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

             /* if (result != null) {
                setState(() {
                  onTextSelected(updatedTexts);
*//*
                  updatedTexts = result;

                  updatedDescription = result;
*//*
                });
              }*/
              if (result != null) {
                setState(() {
                  updatedTexts = result; // Assign the name
                  updatedDescription = "is a great choice!"; // Add custom description
                 // onTextSelected(updatedTexts); // Handle text selection
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
                        "choose a Question Here",
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

                ),
          ),
          SizedBox(height: 20),

          if (isOpen)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
               height:70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xfff4823b),width: 0.3 ),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (updatedTexts),
                        style: TextStyle(
                          color: Color(0xfff4823b),
                          fontFamily: "okra_Bold",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),

                      Container(


                        width: 500,
                        child: Text(
                          (updatedDescription),
                          style: TextStyle(
                            color: Color(0xfff4823b),
                            fontFamily: "Montserrat-Medium",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),


                    ],
                  ),
                ),
              ),

              SizedBox(height: 34),
              Text(
                " Send us a message",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "okra_Medium",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 0, right: 0, top: 10),
                child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 5 ,
                    keyboardType: TextInputType.text,
                    controller: messageController,
                    autocorrect: true,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText:
                      'Message',
                      contentPadding: EdgeInsets.all(10.0),
                      hintStyle: TextStyle(
                        fontFamily: "Roboto_Regular",
                        color: Color(0xffa1a1a1),
                        fontSize:
                        SizeConfig.blockSizeHorizontal *
                            3.5,
                      ),
                      fillColor: Color(0xfff3f3f3),
                      hoverColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xffD9D9D9),
                              width: 1),
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
              SizedBox(height: 34),
              GestureDetector(
                onTap: (){
    ApiClients()
        .PostfeedbackUser(
    messageController.text)
        .then((value) {
    print(value['data']);
    print("Response: $value");

    if (mounted) {
    setState(() {});
    }

    if (value['success'] == true) {
    print(
    "Userssssss....${value['data']?['feedbackUser']}");
    GetStorage().write(ConstantData.UserId,
    value['data']?['feedbackUser']);

    showTopSnackBar(context, 'Feedback submitted successfully');
    Navigator.pop(
    context,
    MaterialPageRoute(
    builder: (context) => MainHome()),
    );
    }git
    });

                },
                child: Center(
                  child: Container(
                      width: parentWidth * 0.77,
                      height: parentHeight * 0.06,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(1, 1)),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xffFEBA69),
                            Color(0xffFE7F64),
                          ],
                        ),

                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Center(
                          child: Text(
                            "Save Ticket",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto-Regular',
                                fontSize: SizeConfig.blockSizeHorizontal * 4.5),
                          ))),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
