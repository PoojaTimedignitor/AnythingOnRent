import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../MyBehavior.dart';
import '../ResponseModule/getContactUsCatResponse.dart';
import '../model/dio_client.dart';
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {


  List<ExistingSupportCategories> itemss = [];
  List<ExistingSupportCategories> filteredItemss = [];
  bool isLoading = true;
  bool isOpen = false;
  String? selectedCategoryId;
bool isSelected = false;
  int selectedIndex = -1;

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


    return Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Container(
    height: SizeConfig.screenHeight * 0.55,
      child:
        Padding(
          padding:  EdgeInsets.only(top: 20),
          child: ScrollConfiguration(
          behavior: MyBehavior(),
                child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: filteredItemss.length,
          itemBuilder: (context, index) {
            bool isSelected = selectedIndex == index;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 7.0),
              width: SizeConfig.screenHeight * 0.5,

              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){

                      setState(() {

                        Navigator.pop(context, {
                          'name': filteredItemss[index].name.toString(),
                          'description': filteredItemss[index].description.toString(),
                          'std': filteredItemss[index].sId.toString(),
                        });
                        selectedIndex = index;
                      });

                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: Container(
                        height: 48,
                        child: Center(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Color(0xff8d4fd6)
                                          : Colors.black, // Outer circle color
                                      width: 1,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                    child: Container(
                                      width: 10, // Inner circle size
                                      height: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected
                                            ? Color(0xff8d4fd6)
                                            : Colors.black,
                                      ),
                                    ),
                                  )
                                      : null,
                                ),

                                Column(
                                  children: [
                                    Container(
                                      width: SizeConfig.screenHeight * 0.37,
                                      child: Text(
                                        filteredItemss[index]
                                            .name
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "okra_Medium",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Container(

                                      width: 300,
                                      child: Text(
                                        filteredItemss[index].description.toString(),
                                        style: TextStyle(
                                          color: CommonColor.grayText,
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

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                   Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Container(
            color: CommonColor.grays,
            height: SizeConfig.screenHeight * 0.0005,
                        ),
                      ),

                ],
              ),
            );
          },
                ),
              ),
        ),
    ),
    );
  }
}
