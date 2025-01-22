/*
import 'package:flutter/material.dart';

import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
import '../model/dio_client.dart';

class EditDeleteBottomSheet extends StatefulWidget {
  final String productId;
  const EditDeleteBottomSheet({super.key, required this.productId});

  @override
  State<EditDeleteBottomSheet> createState() => _EditDeleteBottomSheetState();
}

class _EditDeleteBottomSheetState extends State<EditDeleteBottomSheet> {






  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.22,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Center(
                  child: Container(
                    color: CommonColor.showBottombar.withOpacity(0.2),
                    height: SizeConfig.screenHeight * 0.004,
                    width: SizeConfig.screenHeight * 0.1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 13),
            Center(
              child: Text(
                "Select Options",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                    fontFamily: 'Roboto_Medium',
                    fontWeight: FontWeight.w400,
                    color: CommonColor.Black),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage('assets/images/editing.png'),
                        height: 18),
                    SizedBox(width: 8),
                    Text(
                      " Can edit",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "okra_Medium",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 8),
            GestureDetector(
              onTap: (){

                showDialog(
                  context: context,
                  builder: (
                      BuildContext context,

                      ) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(

                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 9),
                              Text(
                                "Delete Product?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "okra_Medium",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.90, // Inner container width
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.63,
                                  child: Text(
                                    "Are you sure you want to delete this product?",
                                    style: TextStyle(
                                      fontFamily: "Roboto_Regular",
                                      fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.8,
                                      color: CommonColor.grayText,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop(); // Close dialog


                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          width: SizeConfig.screenWidth * 0.25,
                                          height: SizeConfig.screenHeight * 0.05,

                                          child: Center(
                                              child: Text("Cancel",

                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: 'Roboto-Regular',
                                                    fontSize:
                                                    SizeConfig.blockSizeHorizontal *
                                                        4.5),
                                              ))),
                                      GestureDetector(
                                        onTap: (){
                                          print("delete....${(productId)}");
                                          Navigator.of(context).pop(); // Close dialog
                                          deleteProduct(productId);
                                        },
                                        child: Container(
                                            width: SizeConfig.screenWidth * 0.27,
                                            height: SizeConfig.screenHeight * 0.05,
                                            decoration: BoxDecoration(
                                                                          color:  Color(0xffe64949),

                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        Icons.delete_outline_outlined,
                                                        color: CommonColor.white,
                                                        size: 22,
                                                      ),
                                                      Text("Delete",

                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: 'Roboto-Regular',
                                                            fontSize:
                                                            SizeConfig.blockSizeHorizontal *
                                                                4.1),
                                                      ),
                                                    ],
                                                  )),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 27,
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: "okra_Medium",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
*/
