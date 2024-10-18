import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';



class documents extends StatefulWidget {
  const documents({super.key});

  @override
  State<documents> createState() => _documentsState();
}

class _documentsState extends State<documents> {
  File? _image;
  final _images = <XFile>[];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            _image = File(pickedFile.path);
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }



  void _showGallaryDialogBox(BuildContext context) {
    SizeConfig().init(context);
    showDialog(
      context: context,
      builder: (BuildContext context,) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Column(
            children: [
              /*  Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  "Choose Option",
                  style: TextStyle(
                      height: 1,
                      fontSize: SizeConfig.blockSizeHorizontal * 5.0,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      color: CommonColor.black),
                ),
              ),*/
              Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.camera);
                    },
                    child: Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.024),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: SizeConfig.screenHeight * 0.03,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.024,left: SizeConfig.screenHeight*0.024),
                          child: Text(
                            "Camera",
                            style: TextStyle(
                                height: 2.5,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery);
                    },
                    child: Row(

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.0),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: SizeConfig.screenHeight * 0.03,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.0,left: SizeConfig.screenHeight*0.024),
                          child: Text(
                            "Picture and Vedio Library",
                            style: TextStyle(
                                height: 2.5,
                                fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  /* AppPreferences.clearAppPreference();
                  Get.to(() => const SignIn());*/
                },
                child: Padding(
                  padding:  EdgeInsets.only(top: SizeConfig.screenHeight*0.02),
                  child: Container(
                    width: SizeConfig.screenWidth*0.3,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.white,

                      color: CommonColor.Black,

                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            height: 2,
                            fontSize: SizeConfig.blockSizeHorizontal * 4.3,
                            fontFamily: 'Roboto_Medium',
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  //Navigator.of(context).pop();
  // "Picture and Vedio Library ",

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      //backgroundColor:CommonColor.levender,
      body: Column(
        /* shrinkWrap: true,
        padding: EdgeInsets.zero,*/
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.30,
            decoration: BoxDecoration(
              color: CommonColor.Black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),

            // color: CommonColor.appColor,
            // height: SizeConfig.screenHeight * 0.1,
            child: mainHeading(SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
          Container(
            height: SizeConfig.screenHeight * 0.70,
            child: getTextLayout(SizeConfig.screenHeight, SizeConfig.screenWidth),
          ),
        ],
      ),
    );
  }

  Widget mainHeading(double parentHeight, double parentWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.only(
              top: parentHeight * .05, left: parentHeight * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: parentWidth * .02),
                  child: Container(
                    padding: EdgeInsets.only(top: parentHeight * 0.02),
                    child: Icon(
                      Icons.arrow_back_outlined,
                      size: parentHeight * .030,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: parentHeight * 0.01),
                child: Text(
                  "Upload Documents",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 5.5,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: parentWidth * .04),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.arrow_back_outlined,
                    size: parentHeight * .03,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: parentWidth * 0.9,
          child: Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.15,top: parentHeight*0.03
            ),
            child: Text(
              "Upload all the documents for vehicle servicing approval.",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black),
              maxLines: 2,
            ),
          ),
        ),
        Container(
          width: parentWidth * 0.9,
          child: Padding(
            padding: EdgeInsets.only(
                left: parentWidth * 0.14, top: parentHeight * 0.05),
            child: Text(
              "90% completed. Almost there!",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                  fontFamily: 'Roboto_Medium',
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis,
                  color: CommonColor.Black),
              maxLines: 2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: parentWidth * 0.14, top: parentHeight * 0.01),
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 20),
            width: 300,
            height: 05,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: 0.6,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff0500FF),
                ),
                backgroundColor: Color(0xffD6D6D6),
              ),
            ),
          ),
        )
        /* Padding(
          padding: EdgeInsets.only(top: 15, r: parentWidth * 0),
          child: Container(
            color: CommonColor.grays,
            height: SizeConfig.screenHeight * 0.005,
          ),
        ),*/
      ],
    );
  }

  Widget getTextLayout(double parentHeight, double parentWidth) {
    return Padding(
      padding: EdgeInsets.only(bottom: parentHeight*0.02),
      child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: parentHeight * 0.03,
                  left: parentWidth * 0.06,
                  right: parentWidth * 0.06),
              child: Text(
                  "Upload the Scanned copy all the required document mentioned. make sure you make a single folder of all the document with correct naming.",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.7,
                      fontFamily: 'Roboto_Regular',
                      fontWeight: FontWeight.w400,
                      //overflow: TextOverflow.ellipsis,
                      color: CommonColor.Black)),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: parentHeight * 0.03, left: parentWidth * 0.06),
              child: Text("RC Book",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.7,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      //overflow: TextOverflow.ellipsis,
                      color: CommonColor.Black)),
            ),
            GestureDetector(
              onTap: (){
                _showGallaryDialogBox(context);
              },
              child: Padding(
                padding:  EdgeInsets.only(top: parentHeight*0.01),
                child: SizedBox(
                  height: parentHeight*0.10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: parentWidth*0.45,
                        // padding: EdgeInsets.all(20), //padding of outer Container
                        child: DottedBorder(
                          color: Colors.black45, //color of dotted/dash line
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),
                          dashPattern: [4, 5],
                          //dash patterns, 10 is dash width, 6 is space width
                          child:
                          _image == null
                              ? Container(
                            //inner container
                            height: 180, //height of inner container
                            width: double
                                .infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.0),
                                  child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05,),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.01),
                                  child: Text("Upload your file here (Front side)",style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      //overflow: TextOverflow.ellipsis,
                                      color: CommonColor.gray) ,),
                                )
                              ],
                            ),


                          ):
                          Stack(
                            alignment: Alignment.topRight,

                            children: [
                              Container(
                                  width: parentWidth*0.45,


                                  child:

                                  Image.file(_image!)),
                              /*GestureDetector(
                                onTap: (){
                                  _image;
                                  setState(() {

                                  });
                                },
                                child: Padding(
                                  padding:  EdgeInsets.only(right: parentWidth*0.12,),
                                  child: Container(

                                    child: Icon(Icons.cancel_sharp,
                                      color: Colors.red,
                                      size: 20,),
                                  ),
                                ),
                              )*/
                            ],
                          ),


                        ),


                      ),
                      Container(
                          width: parentWidth*0.45,
                          // padding: EdgeInsets.all(20), //padding of outer Container
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(20),

                            color: Colors.black45, //color of dotted/dash line
                            strokeWidth: 1, //thickness of dash/dots
                            dashPattern: [4, 5],
                            //dash patterns, 10 is dash width, 6 is space width
                            child:
                            _image == null

                                ?  Container(
                              //inner container
                              height: 180, //height of inner container
                              width: double
                                  .infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: parentHeight*0.0),
                                    child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: parentHeight*0.01),
                                    child: Text("Upload your file here (Front side)",style: TextStyle(
                                        fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                        fontFamily: 'Roboto_Regular',
                                        fontWeight: FontWeight.w400,
                                        //overflow: TextOverflow.ellipsis,
                                        color: CommonColor.gray) ,),
                                  )
                                ],
                              ),//width to 100% match to parent container.
                              // color:Colors.yellow //background color of inner container
                            ):

                            Stack(
                              alignment: Alignment.topRight,

                              children: [
                                Container(
                                    width: parentWidth*0.45,


                                    child:

                                    Image.file(_image!)),
                                GestureDetector(
                                  onTap: (){
                                    _image;
                                    setState(() {

                                    });
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.only(right: parentWidth*0.12,),
                                    child: Container(

                                      child: Icon(Icons.cancel_sharp,
                                        color: Colors.red,
                                        size: 20,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding:
              EdgeInsets.only(top: parentHeight * 0.023, left: parentWidth * 0.06),
              child: Text("Driving Licence",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.7,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      //overflow: TextOverflow.ellipsis,
                      color: CommonColor.Black)),
            ),
            Padding(
              padding:  EdgeInsets.only(top: parentHeight*0.014),
              child: Container(
                height: parentHeight*0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: parentWidth*0.45,
                      // padding: EdgeInsets.all(20), //padding of outer Container
                      child: DottedBorder(
                        color: Colors.black45, //color of dotted/dash line
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(20),
                        dashPattern: [4, 5],
                        //dash patterns, 10 is dash width, 6 is space width
                        child: Container(
                          //inner container
                          height: 180, //height of inner container
                          width: double
                              .infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.0),
                                child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.01),
                                child: Text("Upload your file here (Front side)",style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.w400,
                                    //overflow: TextOverflow.ellipsis,
                                    color: CommonColor.gray) ,),
                              )
                            ],
                          ),

                          //width to 100% match to parent container.
                          // color:Colors.yellow //background color of inner container
                        ),
                      ),


                    ),
                    Container(
                        width: parentWidth*0.45,
                        // padding: EdgeInsets.all(20), //padding of outer Container
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),

                          color: Colors.black45, //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          dashPattern: [4, 5],
                          //dash patterns, 10 is dash width, 6 is space width
                          child: Stack(
                            alignment: Alignment.topRight,

                            children: [
                              Container(
                                //inner container
                                height: 180, //height of inner container
                                width: double
                                    .infinity,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top: parentHeight*0.0),
                                      child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(top: parentHeight*0.01),
                                      child: Text("Upload your file here (Front side)",style: TextStyle(
                                          fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                          fontFamily: 'Roboto_Regular',
                                          fontWeight: FontWeight.w400,
                                          //overflow: TextOverflow.ellipsis,
                                          color: CommonColor.gray) ,),
                                    )
                                  ],
                                ),//width to 100% match to parent container.
                                // color:Colors.yellow //background color of inner container
                              ),

                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:
              EdgeInsets.only(top: parentHeight * 0.023, left: parentWidth * 0.06),
              child: Text("PUC",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.7,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      //overflow: TextOverflow.ellipsis,
                      color: CommonColor.Black)),
            ),
            Padding(
              padding:  EdgeInsets.only(top: parentHeight*0.014),
              child: Container(
                height: parentHeight*0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: parentWidth*0.45,
                      // padding: EdgeInsets.all(20), //padding of outer Container
                      child: DottedBorder(
                        color: Colors.black45, //color of dotted/dash line
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(20),
                        dashPattern: [4, 5],
                        //dash patterns, 10 is dash width, 6 is space width
                        child: Container(
                          //inner container
                          height: 180, //height of inner container
                          width: double
                              .infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.0),
                                child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.01),
                                child: Text("Upload your file here (Front side)",style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.w400,
                                    //overflow: TextOverflow.ellipsis,
                                    color: CommonColor.gray) ,),
                              )
                            ],
                          ),

                          //width to 100% match to parent container.
                          // color:Colors.yellow //background color of inner container
                        ),
                      ),


                    ),
                    Container(
                        width: parentWidth*0.45,
                        // padding: EdgeInsets.all(20), //padding of outer Container
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),

                          color: Colors.black45, //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          dashPattern: [4, 5],
                          //dash patterns, 10 is dash width, 6 is space width
                          child: Container(
                            //inner container
                            height: 180, //height of inner container
                            width: double
                                .infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.0),
                                  child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.01),
                                  child: Text("Upload your file here (Front side)",style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      //overflow: TextOverflow.ellipsis,
                                      color: CommonColor.gray) ,),
                                )
                              ],
                            ),//width to 100% match to parent container.
                            // color:Colors.yellow //background color of inner container
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:
              EdgeInsets.only(top: parentHeight * 0.023, left: parentWidth * 0.06),
              child: Text("Aadhar Card",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.7,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      //overflow: TextOverflow.ellipsis,
                      color: CommonColor.Black)),
            ),
            Padding(
              padding:  EdgeInsets.only(top: parentHeight*0.014),
              child: Container(
                height: parentHeight*0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: parentWidth*0.45,
                      // padding: EdgeInsets.all(20), //padding of outer Container
                      child: DottedBorder(
                        color: Colors.black45, //color of dotted/dash line
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(20),
                        dashPattern: [4, 5],
                        //dash patterns, 10 is dash width, 6 is space width
                        child: Container(
                          //inner container
                          height: 180, //height of inner container
                          width: double
                              .infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.0),
                                child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.01),
                                child: Text("Upload your file here (Front side)",style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.w400,
                                    //overflow: TextOverflow.ellipsis,
                                    color: CommonColor.gray) ,),
                              )
                            ],
                          ),

                          //width to 100% match to parent container.
                          // color:Colors.yellow //background color of inner container
                        ),
                      ),


                    ),
                    Container(
                        width: parentWidth*0.45,
                        // padding: EdgeInsets.all(20), //padding of outer Container
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),

                          color: Colors.black45, //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          dashPattern: [4, 5],
                          //dash patterns, 10 is dash width, 6 is space width
                          child: Container(
                            //inner container
                            height: 180, //height of inner container
                            width: double
                                .infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.0),
                                  child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.01),
                                  child: Text("Upload your file here (Front side)",style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      //overflow: TextOverflow.ellipsis,
                                      color: CommonColor.gray) ,),
                                )
                              ],
                            ),//width to 100% match to parent container.
                            // color:Colors.yellow //background color of inner container
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:
              EdgeInsets.only(top: parentHeight * 0.03, left: parentWidth * 0.06),
              child: Text("Pan Card",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.7,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      //overflow: TextOverflow.ellipsis,
                      color: CommonColor.Black)),
            ),
            Padding(
              padding:  EdgeInsets.only(top: parentHeight*0.01),
              child: Container(
                height: parentHeight*0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: parentWidth*0.45,
                      // padding: EdgeInsets.all(20), //padding of outer Container
                      child: DottedBorder(
                        color: Colors.black45, //color of dotted/dash line
                        strokeWidth: 1,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(20),
                        dashPattern: [4, 5],
                        //dash patterns, 10 is dash width, 6 is space width
                        child: Container(
                          //inner container
                          height: 180, //height of inner container
                          width: double
                              .infinity,
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.0),
                                child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: parentHeight*0.01),
                                child: Text("Upload your file here (Front side)",style: TextStyle(
                                    fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.w400,
                                    //overflow: TextOverflow.ellipsis,
                                    color: CommonColor.gray) ,),
                              )
                            ],
                          ),

                          //width to 100% match to parent container.
                          // color:Colors.yellow //background color of inner container
                        ),
                      ),


                    ),
                    Container(
                        width: parentWidth*0.45,
                        // padding: EdgeInsets.all(20), //padding of outer Container
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),

                          color: Colors.black45, //color of dotted/dash line
                          strokeWidth: 1, //thickness of dash/dots
                          dashPattern: [4, 5],
                          //dash patterns, 10 is dash width, 6 is space width
                          child: Container(
                            //inner container
                            height: 180, //height of inner container
                            width: double
                                .infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.0),
                                  child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top: parentHeight*0.01),
                                  child: Text("Upload your file here (Front side)",style: TextStyle(
                                      fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                      fontFamily: 'Roboto_Regular',
                                      fontWeight: FontWeight.w400,
                                      //overflow: TextOverflow.ellipsis,
                                      color: CommonColor.gray) ,),
                                )
                              ],
                            ),//width to 100% match to parent container.
                            // color:Colors.yellow //background color of inner container
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:
              EdgeInsets.only(top: parentHeight * 0.03, left: parentWidth * 0.06),
              child: Text("Insurance Policy",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 4.7,
                      fontFamily: 'Roboto_Medium',
                      fontWeight: FontWeight.w400,
                      //overflow: TextOverflow.ellipsis,
                      color: CommonColor.Black)),
            ),
            Padding(
              padding:  EdgeInsets.only(top: parentHeight*0.01,left: parentWidth*0.04,right: parentWidth*0.04),
              child: Container(
                height: parentHeight*0.10,
                child: Container(
                  width: parentWidth*0.45,
                  // padding: EdgeInsets.all(20), //padding of outer Container
                  child: DottedBorder(
                    color: Colors.black45, //color of dotted/dash line
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    dashPattern: [4, 5],
                    //dash patterns, 10 is dash width, 6 is space width
                    child: Container(
                      //inner container
                      height: 180, //height of inner container
                      width: double
                          .infinity,
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: parentHeight*0.0),
                            child: Image(image: AssetImage('assets/images/upload_image.png'),height: parentHeight*0.05),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: parentHeight*0.01),
                            child: Text("Upload your file here (Front side)",style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.w400,
                                //overflow: TextOverflow.ellipsis,
                                color: CommonColor.gray) ,),
                          )
                        ],
                      ),

                      //width to 100% match to parent container.
                      // color:Colors.yellow //background color of inner container
                    ),
                  ),


                ),
              ),
            ),
          ]),
    );
  }
}