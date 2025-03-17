
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
import '../Common_File/ResponsiveUtil.dart';
import '../Common_File/common_color.dart';
import '../Common_File/new_responsive_helper.dart';
import '../NewDioClient.dart';
import '../ResponseModule/getBigSupportViewResponse.dart' as Datasss;

class BigSupportScreen extends StatefulWidget {
  final Datasss.BigSupportData? ticket;

  const BigSupportScreen({super.key, this.ticket});

  @override
  State<BigSupportScreen> createState() => _BigSupportScreenState();
}

class _BigSupportScreenState extends State<BigSupportScreen> {
  bool isLoading = true;
  Datasss.BigSupportData? subBigTicket;

  @override
  void initState() {
    super.initState();
    fetchBigTicketSupport();
  }
  void fetchBigTicketSupport() async {
    setState(() => isLoading = true);
    try {
      Map<String, dynamic> response = await NewApiClients().getBigViewTicket(
        widget.ticket?.userId ?? '',
        widget.ticket?.ticketNumber ?? '',
      );

      if (response.isNotEmpty) {
        var jsonList = Datasss.getBigSupportTicketResponseModel.fromJson(response);
        setState(() {
          subBigTicket = jsonList.data?.isNotEmpty == true ? jsonList.data!.first : null;
          isLoading = false;
        });
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
      backgroundColor: const Color(0xffF5F6FB),
      appBar: AppBar(
        title: const Text(
          "Help Center",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfoRow(Icons.confirmation_number, "Ticket Number", subBigTicket?.ticketNumber),
                buildInfoRow(Icons.description, "Description", subBigTicket?.description),
                buildInfoRow(Icons.date_range, "Date", subBigTicket?.createdAt),
                buildInfoRow(Icons.category, "Category", subBigTicket?.category?.name),
                buildInfoRow(Icons.phone_callback, "Request Call", subBigTicket?.status),
                buildInfoRow(Icons.check_circle_outline, "Status", subBigTicket?.status, isStatus: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String label, String? value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: isStatus ? (value == "Open" ? Colors.green : Colors.red) : Colors.blue),

          const SizedBox(width:10),

          Expanded(
            child: Text(
              "$label: ${value ?? 'N/A'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isStatus ? Colors.green : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}



