import 'package:anything/Admin/helpCentre.dart';
import 'package:anything/ResponseModule/getContactUsCatResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../Common_File/new_responsive_helper.dart';
import '../MyBehavior.dart';
import '../NewDioClient.dart';
import '../newGetStorage.dart';
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
  String selectedCategoryId = "";
  String updatedTexts = "";
  String updatedDescription = "";
  TextEditingController messageController = TextEditingController();


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
  void initState() {
    super.initState();
  }


 /* void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

        return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop();
              return false;
            },

        child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Image(
                      image: AssetImage('assets/images/sucess.png'),
                      height: 65,
                    ),
                    Container(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1),
                          Text(
                            "Your ticket has been raised successfully!",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Now track status of all your tickets in the Support section.",
                            style: TextStyle(
                              color: CommonColor.Black,
                              fontFamily: "Montserrat-Medium",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        print(" Submitting Ticket...");

                        var response = await NewApiClients().NewCreateTicket(
                            selectedCategoryId,
                            messageController.text
                        );

                        print(" API Response: $response");

                        if (mounted) {
                          setState(() {});
                        }

                        if (response['success'] == true) {
                          String? userId = response['data']?['userId'];
                          print(" User ID: $userId");

                          if (userId != null) {
                            await NewAuthStorage.setUserId(userId);
                          }

                          showTopSnackBar(context, ' Question submitted successfully!');

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HelpCenterScreen()),
                          );
                        } else {
                          print(" Error Message: ${response['message']}");
                          showTopSnackBar(context, " Failed to submit question!");
                        }
                      },

                      child: Center(
                        child: Container(
                          width: SizeConfig.screenWidth * 0.75,
                          height: SizeConfig.screenHeight * 0.05,
                          child: Center(
                            child: Text(
                              "Okay",
                              style: TextStyle(
                                color: Color(0xfff44343),
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto-Regular',
                                fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
*/




  void showSuccessDialog(BuildContext context) {

    final responsive = ResponsiveHelper(context);

    if (messageController.text.trim().isEmpty) {
      showTopSnackBar(context, "Message is required!");
      return;
    }

    bool isSubmitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                     // const SizedBox(height: 10),

                      SizedBox(height: responsive.height(10),),           /// new changes

                      Image.asset(
                        'assets/images/sucess.png',
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),

                            Text(
                              "Your ticket has been raised successfully!",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "okra_Medium",
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            //const SizedBox(height: 15),
                            SizedBox(height: responsive.height(15),),        /// new changes

                            Text(
                              "Now track the status of all your tickets in the Support section.",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat-Medium",
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: isSubmitting
                            ? null
                            : () async {
                          setState(() => isSubmitting = true);
                          print("Submitting Ticket...");

                          var response = await NewApiClients().NewCreateTicket(
                            selectedCategoryId,
                            messageController.text,
                          );

                          print("API Response: $response");

                          if (response['success'] == true) {
                            String? userId = response['data']?['userId'];
                            print("User ID: $userId");

                            if (userId != null) {
                              NewAuthStorage.setUserId(userId);
                            }
                            messageController.clear();
                            showTopSnackBar(context, 'Question submitted successfully!');

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HelpCenterScreen()),
                            );
                          } else {
                            print("Error Message: ${response['message']}");
                            showTopSnackBar(context, "Failed to submit question!");
                            setState(() => isSubmitting = false);
                          }
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: BoxDecoration(
                              color: isSubmitting ? Colors.grey : const Color(0xfff44343),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: isSubmitting
                                ? const CircularProgressIndicator(color: Colors.white)
                                 : Text(
                              "Okay",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto-Regular',
                                fontSize: MediaQuery.of(context).size.width * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                     // const SizedBox(height: 16),
                      SizedBox(height: responsive.height(16),),        /// new changes
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {

   // final responsive = ResponsiveHelper(context);                 /// new changes

    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      body: FAQQuations(SizeConfig.screenHeight, SizeConfig.screenWidth),
    );
  }

  Widget FAQQuations(double parentHeight, double parentWidth) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.blockSizeHorizontal,                                 /// new changes
              // width: 250,
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
           // const SizedBox(height: 10),
            Container(
              width: 400,
              child: const Text(
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
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final result = await showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
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
                      return const ContactUs();
                    });

                if (result != null) {
                  setState(() {
                    updatedTexts = result['name'];
                    updatedDescription = result['description'];
                    selectedCategoryId = result['std'];
                    isOpen = true;
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
                      const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Image(
                            image: AssetImage('assets/images/questionmark.png'),
                            height: 20,
                          )),
                      Container(
                        width: SizeConfig.screenHeight * 0.3,
                        child: const Text(
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
                      const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Image(
                            image: AssetImage('assets/images/downarrow.png'),
                            height: 35,
                            color: Color(0xfff44343),
                          )),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            if (isOpen)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Color(0xfff4823b), width: 0.3),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (updatedTexts),
                            style: const TextStyle(
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
                              style: const TextStyle(
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
                  const SizedBox(height: 34),

                  const Text(
                    " Send us a message",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
                    child: TextFormField(
                        textAlign: TextAlign.start,
                        maxLines: 5,
                        keyboardType: TextInputType.text,
                        controller: messageController,
                        autocorrect: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Message',
                          contentPadding: EdgeInsets.all(10.0),
                          hintStyle: TextStyle(
                            fontFamily: "Roboto_Regular",
                            color: Color(0xffa1a1a1),
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                          ),
                          fillColor: Color(0xfff3f3f3),
                          hoverColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffD9D9D9), width: 1),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffD9D9D9), width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                  ),
                  SizedBox(height: 34),
                  GestureDetector(
                    onTap: () {
                      showSuccessDialog(context);
                    },

                    /* onTap: () {
                      ApiClients()
                          .CreateTicket(selectedCategoryId, messageController.text)
                          .then((value) {
                        print(value['data']);
                        print("Response: $value");

                        if (mounted) {
                          setState(() {});
                        }

                        if (value['success'] == true) {
                          // Show dialog on success
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Success"),
                                content: Text("Your ticket has been raised successfully!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Close the dialog
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );

                          print("Userssssss....${value['data']?['userId']}");
                          GetStorage().write(
                              ConstantData.UserId, value['data']?['userId']);

                          // Show a top snack bar for success notification
                          showTopSnackBar(context, 'Question submitted successfully');

                          // Navigate to HelpCenterScreen after raising the ticket
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HelpCenterScreen()),
                          );
                        }
                      });
                    },*/

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
                          gradient: const LinearGradient(
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
                            "Raise Ticket",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto-Regular',
                              fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
