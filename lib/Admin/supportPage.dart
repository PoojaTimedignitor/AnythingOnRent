import 'package:anything/Common_File/new_responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../MyBehavior.dart';
import '../NewDioClient.dart';
import '../ResponseModule/getAllSupportTicket.dart';
import '../model/dio_client.dart';
import 'bigSupportScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class Supportpage extends StatefulWidget {
  final VoidCallback onNeedHelpTap;
  const Supportpage({super.key, required this.onNeedHelpTap});

  @override
  State<Supportpage> createState() => _SupportpageState();
}

class _SupportpageState extends State<Supportpage> {
  bool isLoading = true;
  List<Data> SubTicket = [];
  List<Data> filteredTicket = [];
  String userIds = '';
  bool isShowMore = false;

  void fetchAllTicketSupport() async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> response = await NewApiClients().getAllTicket();

      if (response.isNotEmpty) {
        var jsonList = getAllSupportTicket.fromJson(response);

        setState(() {
          SubTicket = jsonList.data ?? [];
          filteredTicket = List.from(SubTicket);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print(" No data available.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(" Error fetching Ticket: $e");
    }
  }


  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    fetchAllTicketSupport();
  }

  @override
  Widget build(BuildContext context) {

    final responsive = ResponsiveHelper(context);


    return Scaffold(
      backgroundColor: Color(0xffF5F6FB),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [

            SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
                widget.onNeedHelpTap();
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  // height: 40,
                  // height: SizeConfig.screenHeight * 0.06,                             /// new changes
                  // width: SizeConfig.screenHeight * 0.5,
                  height: responsive.height(48),                            /// NEW CHANGES
                  width: responsive.width(187.5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.help_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                          //const SizedBox(width: 8),
                          SizedBox( width: responsive.width(8)),                 /// new changes
                          //width: responsive.width(187.5),
                          Text(
                            " Need Help? Contact Us",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              //fontSize: 15,
                              fontSize: responsive.fontSize(15),                  /// new changes
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final url =
                    'https://admin-fyu1.onrender.com/api/pages/display/terms-of-service';
                print("Ad URLllll: $url");

                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print("Could not launch the URL");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
                child: Container(
                  // height: 40,
                  // width: SizeConfig.screenHeight * 0.5,
                  height: responsive.height(40),                                /// NEW CHANGES
                  width: responsive.width(0.5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.help_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            " Terms and conditions",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                             // fontSize: 15,
                              fontSize: responsive.fontSize(15),             /// new changes
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      )),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final url =
                    'https://admin-fyu1.onrender.com/api/pages/display/privacy-policy';
                print("Ad URLllll: $url");


                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print("Could not launch the URL");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
                child: Container(
                  // height: 40,
                  // width: SizeConfig.screenHeight * 0.5,
                  height: responsive.height(40),                                /// NEW CHANGES
                  width: responsive.width(0.5),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.help_outline, // Icon before the text
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            " Privacy Policy",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                             // fontSize: 15,
                              fontSize: responsive.fontSize(15),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      )),
                ),
              ),
            ),

            const SizedBox(height: 50),

            Container(
              width: responsive.width(0.5),                       /// new changes
             // width: SizeConfig.screenWidth,
              child: filteredTicket.isEmpty
                  ? SizedBox(
                  height: responsive.height(40),                                /// NEW CHANGES
                     // height: SizeConfig.screenHeight * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: const AssetImage('assets/images/ticket.png'),
                              //height: SizeConfig.screenHeight * 0.18
                              height: responsive.height(10),                                /// NEW CHANGES
                          ),
                         const  SizedBox(height: 16),
                         const  Text(
                            "You haven't bought any ticket yet",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ))
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    BigSupportScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {

                              const begin = Offset(1.0,
                                  0.0);
                              const end = Offset
                                  .zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            },
                          ),
                        );
                      },
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 17),
                               Text(
                                "    Raise Ticket",
                                style: TextStyle(
                                  color: Color(0xfff44343),
                                  fontFamily: "okra_bold",
                                  //fontSize: 19,
                                  fontSize: responsive.fontSize(19),                    /// new changes
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ListView.builder(
                                itemCount:
                                    isShowMore ? filteredTicket.length : 1,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final ticket = filteredTicket[index];
                                  String formattedDate =
                                      formatDate(ticket.createdAt.toString());

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    child: Container(
                                      height: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0xffea926f)
                                                  .withOpacity(0.2),
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                              offset: const Offset(0, 1)),
                                        ],
                                        border: Border.all(
                                            color: const Color(0xfff4823b),
                                            width: 0.3),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${ticket.ticketNumber}",
                                                  style:  TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                     // fontSize: 16
                                                    fontSize: responsive.fontSize(16),              /// new changes
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward_ios_sharp,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 5),

                                            Container(
                                              width:
                                                 // ResponsiveUtil.fontSize(350),
                                              responsive.fontSize(350),
                                        child: Text(
                                                "${ticket.category?.name.toString()} Display All rental product options in your choose location ",
                                                style: TextStyle(
                                                  color: CommonColor.grayText,
                                                  fontFamily:
                                                      "Montserrat-Medium",
                                                 // fontSize: ResponsiveUtil.fontSize(12),
                                                  fontSize: responsive.fontSize(12),                   /// new changes
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 23),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "$formattedDate",
                                                  style: TextStyle(
                                                      color: Color(0xff3684F0),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      //fontSize: ResponsiveUtil.fontSize(13)
                                                    fontSize: responsive.fontSize(13),                    /// new changes
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  height: ResponsiveUtil.height(
                                                      25), // Responsive height
                                                  width:
                                                      ResponsiveUtil.width(75),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Text(
                                                      " ${ticket.status.toString()} ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      //  fontSize: ResponsiveUtil.fontSize(15),
                                                        fontSize: responsive.fontSize(15),                    /// new changes
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              if (filteredTicket.length > 2 && !isShowMore)

                               /* GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isShowMore = true;
                                    });
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 200,
                                      height: 35,
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                            SizedBox(width: 12),
                                            Text(
                                              "Show More",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "okra_Medium",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),*/

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(onPressed: (){
                                    setState(() {
                                      isShowMore = true;
                                    });
                                  },
                                      child:  Text('Show More', style: TextStyle(
                                         // fontSize: 16
                                        fontSize: responsive.fontSize(16),                        /// new changes
                                      ),)),
                                   IconButton(onPressed: (){
                                     setState(() {
                                       isShowMore = true;
                                     });
                                   } ,
                                       icon: const Icon(Icons.keyboard_arrow_down_rounded,))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ),

            /*  Text("    ANYTHING ON RENT",
                style: TextStyle(
                  fontFamily: "okra_extrabold",
                  fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                  color: Color(0xffC6C6C6),
                  fontWeight: FontWeight.w600,
                ))*/
          ],
        ),
      ),
    );
  }
}
