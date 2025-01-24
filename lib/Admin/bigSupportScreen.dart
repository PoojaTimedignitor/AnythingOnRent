import 'package:anything/Common_File/SizeConfig.dart';
import 'package:anything/ResponseModule/getBigSupportViewResponse.dart';
import 'package:flutter/cupertino.dart';
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
  List<Data> SubBigTicket = [];
  List<Data> filteredTicket = [];
  String userIds = '';
  String ticketNumbers = '';

  Future<void> fetchBigTicketSupport(String userId, String ticketNumber) async {
    setState(() {
      isLoading = true;
    });

    try {
      Map<String, dynamic> response = await ApiClients().getBigViewTicket(userId, ticketNumber);

      if (response.isNotEmpty) {
        setState(() {
          SubBigTicket = response['data'];
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
              height: ResponsiveUtil.height(SizeConfig.screenHeight*0.4), // Responsive height
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
                Text("Ticket Number: ${SubBigTicket}",)
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
