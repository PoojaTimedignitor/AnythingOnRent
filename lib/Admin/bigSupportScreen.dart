
/*
import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/ResponseModule/getBigSupportViewResponse.dart';
import 'package:flutter/material.dart';

import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/common_color.dart';
import '../model/dio_client.dart';
class BigSupportScreen extends StatefulWidget {

  const BigSupportScreen({super.key,});

  @override
  State<BigSupportScreen> createState() => _BigSupportScreenState();
}

class _BigSupportScreenState extends State<BigSupportScreen> {

  bool isLoading = true;
//  Data? subBigTicket;
  getBigViewSupportTicket? subBigTicket;
  String userIds = '';
  String ticketNumbers = '';

  Future<void> fetchBigTicketSupport(String userId, String ticketNumber) async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> response = await ApiClients().getBigViewTicket(userId, ticketNumber);
      print("API Response: $response");

      if (response.isNotEmpty && response['data'] != null) {
        subBigTicket = getBigViewSupportTicket.fromJson(response);
        print("Parsed SubBigTicket: ${subBigTicket?.toJson()}"); // Print parsed data
      } else {
        print("No data or invalid response structure.");
      }
    } catch (e) {
      print("Error fetching Ticket: $e");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }




  @override
  void initState() {
    super.initState();
    fetchBigTicketSupport(userIds, ticketNumbers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffF5F6FB),
        appBar: AppBar(
          title: Text(
            "Help Center",
            style: TextStyle(
              fontFamily: "Montserrat-Medium",
              fontSize: ResponsiveUtil.fontSize(16),
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
                Navigator.pop(context);
            },
          ),
        ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Text("View Raise Ticket",style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: ResponsiveUtil.fontSize(20),
            color: Color(0xffE3654A),



            fontWeight: FontWeight.w200,
          ),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: ResponsiveUtil.height(SizeConfig.screenHeight*0.4),
             // width: ResponsiveUtil.width(SizeConfig.screenWidth*0.2),
          
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color:
              CommonColor.SearchBar.withOpacity(0.2),
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: Offset(0, 1)),
                ],
                color: Colors.white,
                border: Border.all(
                    color:  CommonColor.SearchBar, width: 0.3),

                borderRadius: BorderRadius.circular(10),
              ),child:Column(
              children: [
                Text("Ticket Number: ${subBigTicket?.ticketNumber ?? ''}", style: TextStyle(fontSize: 18)),


              ],
            )
            ),
          ),
        ],


      )
      /*Stack(
        children: [
        Container(
        height: 280,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/support.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),)
        ],
      ),*/
    );
  }
}
 */






import 'package:flutter/material.dart';
import '../Common_File/new_responsive_helper.dart';
import '../NewDioClient.dart';
import '../ResponseModule/getBigSupportViewResponse.dart' as Datasss;
import '../ResponseModule/getBigSupportViewResponse.dart';
import '../newGetStorage.dart';

class BigSupportScreen extends StatefulWidget {
  final String ticketNumber;
  final Datasss.BigSupportData? ticket;

  const BigSupportScreen({super.key, this.ticket, required this.ticketNumber});

  @override
  State<BigSupportScreen> createState() => _BigSupportScreenState();
}

class _BigSupportScreenState extends State<BigSupportScreen> {
  bool isLoading = true;
  Datasss.BigSupportData? subBigTicket;

  @override
  void initState() {
    fetchBigTicketSupport();
    super.initState();

  }
  void fetchBigTicketSupport() async {
    setState(() => isLoading = true);
    try {
      String? userId = await NewAuthStorage.getUserId();
      if (userId == null) {
        setState(() => isLoading = false);
        print("User ID not found in local storage!");
        return;
      }

      print("Fetching Ticket for UserID: $userId, Ticket Number: ${widget.ticketNumber}");

      Map<String, dynamic> response = await NewApiClients().getBigViewTicket(
        userId,
        widget.ticketNumber,
      );

      if (response.isNotEmpty) {

        if (response['data'] is Map<String, dynamic>) {
          var jsonData = BigSupportData.fromJson(response['data']);
          setState(() {
            subBigTicket = jsonData;
            isLoading = false;
          });
        } else {
          setState(() => isLoading = false);
          print("Unexpected data format!");
        }
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Error fetching Ticket: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      //  backgroundColor: Colors.blueGrey,
      backgroundColor: const Color(0xffF5F6FB),
      appBar: AppBar(
        title: const Text(
          "Help Center",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFA855F7),
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:

      isLoading
          ? const Center(
          child: CircularProgressIndicator())
          : subBigTicket == null
          ? const Center(child: Text("No Data Available"))
          : Padding(
        //padding: const EdgeInsets.all(10.0),
          padding: responsive.getPadding(all: 10),
          child:   Card(
            //color: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.orange.shade50, width: 1.5),
            ),
            elevation: 6,
            shadowColor: Colors.pink.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              // padding: const EdgeInsets.all(16),
              padding: responsive.getPadding(all: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    subBigTicket?.ticketNumber ?? "Missing the Ticket Number",
                    style:  TextStyle(
                      //fontSize: 17,
                        fontSize: responsive.fontSize(17),
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),

                  // const SizedBox(height: 7),
                  SizedBox(height: responsive.height(7)),           /// New changes

                  Text(
                    subBigTicket?.description ?? "Missing the Ticket Description",
                    style: TextStyle(
                      fontSize: responsive.fontSize(13.3),
                      color: Colors.grey.shade700,
                      fontFamily: "Montserrat-Medium",
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                    ),
                    // maxLines: 3,
                    // overflow: TextOverflow.ellipsis,
                  ),

                  //const SizedBox(height: 12),
                  SizedBox(height: responsive.height(12)),           /// New changes

                  Card(
                    //  color: Colors.orange.shade50,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 2,
                    shadowColor: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                      child: Text(
                        subBigTicket?.category?.name ?? "Missing the Ticket Category",
                        style: TextStyle(
                          // fontSize: 16,
                            fontSize: responsive.fontSize(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.orange.shade800
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),

                  //const SizedBox(height: 8),
                  SizedBox(height: responsive.height(8)),           /// New changes

                  Row(
                    children: [
                      const Icon(Icons.phone_callback, color: Colors.green, size: 20),

                      //const SizedBox(width: 10),
                      SizedBox(width: responsive.width(responsive.isMobile ? 10 : responsive.isTablet ? 20 : 30),),               /// new change width

                      Text(
                        subBigTicket?.callRequested == true ? "Yes" : "No",
                        style:  TextStyle(
                            fontFamily: "okra_medium",
                            //fontSize: 16,
                            fontSize: responsive.fontSize(16),
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),

                  //const SizedBox(height: 8),
                  SizedBox(height: responsive.height(10)),           /// New changes

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_rounded, size: responsive.width(15), color: Colors.blue),

                            //const SizedBox(width: 4),
                            SizedBox( width: responsive.width(responsive.isMobile ? 10 : responsive.isTablet ? 20 : 30),),

                            Text(
                              formatDate(subBigTicket?.createdAt),
                              style:  TextStyle(
                                // fontSize: 15,
                                  fontSize: responsive.fontSize(15),
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: buildInfoRow(Icons.check_circle_outline, "", subBigTicket?.status, isStatus: true, showIcon: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }



  Widget buildInfoRow(IconData icon, String label, String? value, {bool isStatus = false, bool showIcon = false}) {
    final responsive = ResponsiveHelper(context);

    bool isOpen = value?.toLowerCase() == "open";

    return Padding(
      //padding: EdgeInsets.symmetric(vertical: responsive.height(40)),
      padding: responsive.getPadding(vertical: 4),
      child: Row(
        children: [
          if (showIcon)
            Icon(
              icon,
              color: isStatus ? (isOpen ? Colors.green : Colors.red) : Colors.blue,
            ),

          if (showIcon)

            SizedBox(width: responsive.width(8)),

          Expanded(
            child: Container(
              height: responsive.height(responsive.isMobile ? 30 : responsive.isTablet ? 32 : 36),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isStatus ? (isOpen ? Colors.green.shade50 : Colors.red.shade50) : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isStatus ? (isOpen ? Colors.green : Colors.red) : Colors.grey,
                  width: 1.2,
                ),
              ),
              child: Center(
                child: Text(
                  value?.toUpperCase() ?? 'N/A',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.fontSize(14),
                    color: isStatus ? (isOpen ? Colors.green : Colors.red) : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "N/A";
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
  }
}




