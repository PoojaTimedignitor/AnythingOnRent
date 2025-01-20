import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../ResponseModule/getAllSupportTicket.dart';
import '../model/dio_client.dart';
import 'FAQ.dart';
import 'helpCentre.dart';



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
  String userId = '';
  void fetchAllTicketSupport(String userId) async {
    setState(() {
      isLoading = true;
    });
    try {
      Map<String, dynamic> response = await ApiClients().getAllTicket(userId);


      var jsonList = getAllSupportTicket.fromJson(response);

      setState(() {
        SubTicket = jsonList.data ?? []; // Use the correct property from the model
        filteredTicket = List.from(SubTicket);
        isLoading = false;
      });
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
    fetchAllTicketSupport(userId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container (
            height: SizeConfig.screenHeight * 0.3,
            width: SizeConfig.screenWidth,

            child: filteredTicket.isEmpty? Column(
              children: [
                Image(image: AssetImage('assets/images/ticket.png'), height: SizeConfig.screenHeight * 0.18),
                SizedBox(height: 16),
                Text("You havent't bought any ticket yet", style: TextStyle(
                  color: Colors.black,
                  fontFamily: "okra_Medium",
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),)
              ],
            ):ListView.builder(
              itemCount: filteredTicket.length,
              itemBuilder: (context, index) {
                final ticket = filteredTicket[index];
                return ListTile(
                  title: Text(
                    "Ticket #${ticket.ticketNumber}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Category: ${ticket.category?.name}"),
                  trailing: Text(
                    ticket.status ?? "",
                    style: TextStyle(
                      color: ticket.status == "Open"
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              height: 40,
              width: SizeConfig.screenHeight*0.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))

              ),child:  GestureDetector(
              onTap: () {

                widget.onNeedHelpTap();
              },

              child: Padding(
                  padding:  EdgeInsets.all(8.0),
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
                  )

              ),
            ),

            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4,left: 10,right: 10),
            child: Container(
              height: 40,
              width: SizeConfig.screenHeight*0.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))

              ),child: Padding(
                padding:  EdgeInsets.all(8.0),
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
                )

            ),

            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 14,left: 10,right: 10),
            child: Container(
              height: 40,
              width: SizeConfig.screenHeight*0.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))

              ),child: Padding(
                padding:  EdgeInsets.all(8.0),
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
                )

            ),

            ),
          ),
          SizedBox(height: 50),
          Text("    ANYTHING ON RENT",  style: TextStyle(
            fontFamily: "okra_extrabold",
            fontSize: SizeConfig.blockSizeHorizontal * 5.5,
            color: Color(0xffC6C6C6),
            fontWeight: FontWeight.w600,
          ))
        ],
      ),
    );
  }
}
