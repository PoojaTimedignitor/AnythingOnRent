import 'package:anything/MyBehavior.dart';
import 'package:flutter/material.dart';
import '../Common_File/SizeConfig.dart';
import '../Common_File/common_color.dart';
class Userfeedback extends StatefulWidget {
  const Userfeedback({super.key});

  @override
  State<Userfeedback> createState() => _UserfeedbackState();
}

class _UserfeedbackState extends State<Userfeedback> {
  final _productDiscriptionFocus = FocusNode();
  TextEditingController productDiscriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: SizeConfig.screenHeight * 0.40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          //  borderRadius: BorderRadius.circular(15)
        ),child: ScrollConfiguration(behavior: MyBehavior(), child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
          //  height: SizeConfig.screenHeight * 0.23,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.4),
                        child: Container(
                          color: CommonColor.showBottombar
                              .withOpacity(0.2),
                          height: SizeConfig.screenHeight * 0.004,
                          width: SizeConfig.screenHeight * 0.1,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.25),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenHeight * 0.01),
                          child: Icon(
                            Icons.close,
                            size: SizeConfig.screenHeight * .03,
                            color: CommonColor.Black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  Hey there 👋",
                      style: TextStyle(
                        color: Color(0xffFE7F64),
                        letterSpacing: 0.9,
                        fontFamily: "okra_Medium",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "  Help us get better for you!",
                      style:TextStyle(
                        color: Color(0xffFE7F64),
                        letterSpacing: 0.9,
                        fontFamily: "okra_Medium",
                        fontSize: SizeConfig.blockSizeHorizontal * 4.2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 27),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF5F6FB),
                        borderRadius: BorderRadius.circular(10)),
                    height: SizeConfig.screenHeight * 0.28,
                    width: SizeConfig.screenWidth * 0.94,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Text(
                          "    Rate Your Overall Exper",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "okra_Medium",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: TextFormField(
                              textAlign: TextAlign.start,
                              maxLines: 6,
                              focusNode: _productDiscriptionFocus,
                              keyboardType: TextInputType.text,
                              controller: productDiscriptionController,
                              autocorrect: true,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText:
                                'HD cameras capture images and videos in 1920x1080 pixels and a resolution of 1080p. 4K cameras, on the other hand',
                                contentPadding: EdgeInsets.all(10.0),
                                hintStyle: TextStyle(
                                  fontFamily: "Roboto_Regular",
                                  color: Color(0xff7D7B7B),
                                  fontSize:
                                  SizeConfig.blockSizeHorizontal *
                                      3.5,
                                ),
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black12, width: 1),
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      ),
    );
  }
}
