import 'package:anything/MyBehavior.dart';
import 'package:flutter/material.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../ConstantData/Constant_data.dart';
import '../MainHome.dart';
import '../NewDioClient.dart';
import '../model/dio_client.dart';
import 'package:get_storage/get_storage.dart';

import '../newGetStorage.dart';

class Userfeedback extends StatefulWidget {
  const Userfeedback({super.key});

  @override
  State<Userfeedback> createState() => _UserfeedbackState();
}

class _UserfeedbackState extends State<Userfeedback> {
  final _productDiscriptionFocus = FocusNode();
  TextEditingController productDiscriptionController = TextEditingController();

  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: SizeConfig.screenHeight *
            0.7,
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


    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.55,
    /*    decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          //  borderRadius: BorderRadius.circular(15)
        ),*/
        child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  //  height: SizeConfig.screenHeight * 0.23,
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
                              padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.4),
                              child: Container(
                                color:
                                    CommonColor.showBottombar.withOpacity(0.2),
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
                                  left: SizeConfig.screenWidth * 0.25),
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.screenHeight * 0.01),
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
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hey there 👋",
                              style: TextStyle(
                                color: Color(0xffFE7F64),
                                letterSpacing: 0.9,
                                fontFamily: "okra_Medium",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Help us get better for you!",
                              style: TextStyle(
                                color: Color(0xffFE7F64),
                                letterSpacing: 0.9,
                                fontFamily: "okra_Medium",
                                fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 27),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xffF5F6FB),
                              borderRadius: BorderRadius.circular(10)),
                          height: SizeConfig.screenHeight * 0.28,
                          width: SizeConfig.screenWidth * 0.94,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Text(
                                "    Rate Your Overall Experiance",
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
                                    textAlign: TextAlign.start,
                                    maxLines: 6,
                                    focusNode: _productDiscriptionFocus,
                                    keyboardType: TextInputType.text,
                                    controller: productDiscriptionController,
                                    autocorrect: true,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText:
                                          'HD cameras capture images and videos in 1920x1080 pixels and a resolution of 1080p. 4K cameras, on the other hand',
                                      contentPadding: EdgeInsets.all(10.0),
                                      hintStyle: TextStyle(
                                        fontFamily: "Roboto_Regular",
                                        color: Color(0xff7D7B7B),
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.5,
                                      ),
                                      fillColor: Colors.white,
                                      hoverColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black12, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          NewApiClients()
                              .NewPostfeedbackUser(
                              productDiscriptionController.text)
                              .then((value) async {
                            print(value['data']);
                            print("Response: $value");

                            if (mounted) {
                              setState(() {});
                            }



                            if (value['success'] == true) {
                              String? userId = value['data']?['feedbackUser'];
                              if (userId != null) {
                                await NewAuthStorage.setUserId(userId);
                                print("User ID Stored: $userId");
                              } else {
                                print("Error: userId is null");
                              }

                              showTopSnackBar(context, 'Feedback submitted successfully');
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainHome(lat: '', long: '', showLoginWidget: false)),
                              );
                            }
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.04,
                                right: SizeConfig.screenWidth * 0.04),
                            child: Container(
                                width: SizeConfig.screenWidth * 0.77,
                                height: SizeConfig.screenHeight * 0.06,
                                decoration: BoxDecoration(
                                  /*  boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1)),
                            ],*/
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color(0xffFEBA69),
                                      Color(0xffFE7F64),
                                    ],
                                  ),
                                  /*   border: Border.all(
                          width: 1, color: CommonColor.APP_BAR_COLOR),*/ //Border.
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Roboto-Regular',
                                          fontSize:
                                          SizeConfig.blockSizeHorizontal * 4.3),
                                    ))),
                          ),
                        ),
                      ),




                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
