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


    List<Widget> options = [
      {
        'label': "Need Help? Contact Us",
        'icon': Icons.help_outline,
        'onTap': () async => widget.onNeedHelpTap(),
      },
      {
        'label': "Terms and Conditions",
        'icon': Icons.article_outlined,
        'onTap': () async {
          final url = 'https://admin-fyu1.onrender.com/api/pages/display/terms-of-service';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            print("Could not launch the URL");
          }
        },
      },
      {
        'label': "Privacy Policy",
        'icon': Icons.privacy_tip_outlined,
        'onTap': () async {
          final url = 'https://admin-fyu1.onrender.com/api/pages/display/privacy-policy';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            print("Could not launch the URL");
          }
        },
      },
    ].map((item) {
      return GestureDetector(
        onTap: item['onTap'] as Function(),
        child: Padding(
          padding: responsive.getPadding(all: 6),
          child: Container(
            height: responsive.height(responsive.isMobile ? 40 : responsive.isTablet ? 55 : 70),                          /// new change
            width: responsive.width(responsive.isMobile ? 320 : responsive.isTablet ? 370 : 420),                      /// new change
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(responsive.width(12)),
              border: Border.all(
                color: Colors.orange.shade400,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.shade400.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: responsive.getPadding(all: 10),
              child: Row(
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: Colors.black,
                    size: responsive.width(18),
                  ),

                  SizedBox(width: responsive.width(12)),                            /// new changes

                  Expanded(
                    child: Text(
                      item['label'] as String,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "okra_Medium",
                        fontSize: responsive.fontSize(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size: responsive.width(15),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();


    return Scaffold(
      backgroundColor: const Color(0xffF5F6FB),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [


            SizedBox(height: responsive.height(20),),        /// new changes


            Column(
              children: options,
            ),


            SizedBox(height: responsive.height(30),),        /// new changes

            Container(
                width: responsive.width(0.5),                       /// new changes

                child: filteredTicket.isEmpty
                    ? SizedBox(
                    height: responsive.height(300),                                /// NEW CHANGES

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage('assets/images/ticket.png'),

                          height: responsive.height(130),                                /// NEW CHANGES
                        ),

                        SizedBox(height: responsive.height(16),),        /// new changes

                        Text(
                          "You haven't bought any ticket yet",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "okra_Medium",
                            fontSize: responsive.fontSize(17),                      /// new changes
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ))
                    :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: responsive.height(17)),           /// New changes

                    Text(
                      "    Raise Ticket",
                      style: TextStyle(
                        color: const Color(0xfff44343),
                        fontFamily: "okra_bold",
                        fontSize: responsive.fontSize(19),                /// New changes
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: responsive.height(20)),


                    ...filteredTicket.asMap().entries
                        .where((entry) => isShowMore || entry.key < 2)
                        .map((entry) {
                      int index = entry.key;
                      var ticket = entry.value;

                      String formattedDate = formatDate(ticket.createdAt.toString());
                      print("kkkk ${ticket.ticketNumber.toString()}");

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  BigSupportScreen(ticketNumber: ticket.ticketNumber.toString()),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(position: offsetAnimation, child: child);
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: responsive.getPadding(horizontal: 13),
                          child: Column(
                            children: [
                              Container(
                                height: responsive.height(responsive.isMobile ? 170 : responsive.isTablet ? 190 : 210),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  gradient: LinearGradient(
                                    colors: [Colors.white, Colors.orange.shade50],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      spreadRadius: 2,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.orange.shade300,
                                    width: 1.2,
                                  ),
                                  borderRadius: BorderRadius.circular(responsive.width(12)),
                                ),
                                child: Padding(
                                  padding: responsive.getPadding(all: 14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${ticket.ticketNumber}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: responsive.fontSize(15),
                                              color: Colors.black87,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: responsive.width(15),
                                            color: Colors.orange.shade700,
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: responsive.height(6)),

                                      // **Ticket Category**
                                      Container(
                                        width: responsive.width(responsive.isMobile ? 370 : 500),
                                        child: Text(
                                          "${ticket.category?.name.toString()} - Explore rental product options at your selected location",
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontFamily: "Montserrat-Medium",
                                            fontSize: responsive.fontSize(13),
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.4,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      SizedBox(height: responsive.height(18)),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.calendar_today_rounded, size: responsive.width(14), color: Colors.blue),
                                              SizedBox(width: 4),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  color: Colors.blue.shade700,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: responsive.fontSize(13),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Container(
                                            height: responsive.height(responsive.isMobile ? 30 : responsive.isTablet ? 32 : 36),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: ticket.status.toString().toLowerCase() == "open"
                                                  ? Colors.green.shade50
                                                  : Colors.red.shade50,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                color: ticket.status.toString().toLowerCase() == "open"
                                                    ? Colors.green
                                                    : Colors.red,
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                ticket.status.toString().toUpperCase(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: responsive.fontSize(14),
                                                  color: ticket.status.toString().toLowerCase() == "open"
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: responsive.height(25)), // Space in ticket
                            ],
                          ),
                        ),
                      );
                    }).toList(),

                    if (filteredTicket.length > 2) // Show More button (if more than 2 tickets)
                      Column(
                        children: [
                          SizedBox(height: responsive.height(responsive.isMobile ? 1 : responsive.isTablet ? 15 : 20)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isShowMore = !isShowMore;
                                  });
                                },
                                child: Text(
                                  isShowMore ? 'Show Less' : 'Show More',
                                  style: TextStyle(
                                    fontSize: responsive.fontSize(16),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShowMore = !isShowMore;
                                  });
                                },
                                icon: Icon(
                                  isShowMore ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                  size: responsive.width(22),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                )




            ),
          ],
        ),
      ),
    );
  }
}
