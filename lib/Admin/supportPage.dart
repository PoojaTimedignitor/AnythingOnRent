import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../MyBehavior.dart';
import '../ResponseModule/getAllSupportTicket.dart';
import '../model/dio_client.dart';

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
  void fetchAllTicketSupport(String userId) async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> response = await ApiClients().getAllTicket(userId);

      if (response != null && response.isNotEmpty) {
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
        print("No data available.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching Ticket: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllTicketSupport(userIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
        //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                height: 40,
                width: SizeConfig.screenHeight * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: GestureDetector(
                  onTap: () {
                    widget.onNeedHelpTap();
                  },
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.help_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            " Need Help? Contact Us",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "okra_Medium",
                              fontSize: 15,
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
            Padding(
              padding: EdgeInsets.only(top: 4, left: 10, right: 10),
              child: Container(
                height: 40,
                width: SizeConfig.screenHeight * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_outline, // Icon before the text
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          " Terms and conditions",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "okra_Medium",
                            fontSize: 15,
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
            Padding(
              padding: EdgeInsets.only(top: 14, left: 10, right: 10),
              child: Container(
                height: 40,
                width: SizeConfig.screenHeight * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_outline, // Icon before the text
                          color: Colors.black,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          " Privacy Policy",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "okra_Medium",
                            fontSize: 15,
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
            SizedBox(height: 50),
            Container(

              width: SizeConfig.screenWidth,
              child: filteredTicket.isEmpty
              ? SizedBox(
                height: SizeConfig.screenHeight * 0.3,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Image(
                      image: AssetImage('assets/images/ticket.png'),
                      height: SizeConfig.screenHeight * 0.18),
                  SizedBox(height: 16),
                  Text(
                    "You havent't bought any ticket yet",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ))
                : SizedBox(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    Text("    Raise Ticket",style: TextStyle(
                      color: Color(0xfff44343),
                      fontFamily: "okra_bold",
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),),
                    ListView.builder(
                      itemCount: isShowMore ? filteredTicket.length : 2,
                      physics: NeverScrollableScrollPhysics(), // Disable independent scrolling
                      shrinkWrap: true, // Allow ListView to size itself
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final ticket = filteredTicket[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          child: Container(
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color:
                                    Color(0xffea926f).withOpacity(0.2),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                    offset: Offset(0, 1)),
                              ],
                              border: Border.all(
                                  color: Color(0xfff4823b), width: 0.3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${ticket.ticketNumber}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 350,
                                      child: Text(
                                        "${ticket.category?.name.toString()} Display All rental product options in your choose location ",
                                        style: TextStyle(
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
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          " Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xfff4823b),
                                                width: 0.3),
                                            borderRadius:
                                            BorderRadius.circular(3),
                                          ),
                                          child: Center(
                                            child: Text(
                                              " ${ticket.status.toString()}",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                   // SizedBox(height: 5),
                    if (filteredTicket.length > 2 && !isShowMore)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isShowMore = true; // Show all tickets
                          });
                        },
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 35,

                            child: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xfff44343),
                                    size: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Show More",
                                    style: TextStyle(
                                      color: Color(0xfff44343),
                                      fontFamily: "okra_Medium",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),),
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
