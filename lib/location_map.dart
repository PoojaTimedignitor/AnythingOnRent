
import 'dart:async';


import 'package:anything/MainHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'Authentication/register_screen.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'createProduct.dart';




class LocationMapScreen extends StatefulWidget {


  const LocationMapScreen({super.key,});

  @override
  State<LocationMapScreen> createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {



  final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? controller;

  List<Placemark>? placeMark;
  Timer? _debounce;
  String name = "";
  String street = "";
  String subLocality = "";
  String locality = "";
  String postalCode = "";
  String administrativeArea = "";
  String country = "";
  double selectLat = 0.0;
  double selectLong = 0.0;

  static const kGoogleApiKey = "AIzaSyDCazNyr62owvI09pzdkVdZ7_t8a8T3XzU";

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(18.6011, 73.7641),
      zoom: 18
  );


  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(28.7041, 77.1025),
      infoWindow: InfoWindow(title: 'marker'),
    )
  ];
  @override
  void dispose() {
    // Clean up any resources, listeners, or controllers
    super.dispose();
  }


  @override
  void initState() {
    super.initState();

    getUserCurrentLocation().then((value) async {
      if (!mounted) return;  // Check if widget is still mounted

      selectLat = value?.latitude ?? 0.0;
      selectLong = value?.longitude ?? 0.0;

      CameraPosition cameraPosition = CameraPosition(
        zoom: 18,
        target: LatLng(selectLat, selectLong),
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      placeMark = await placemarkFromCoordinates(selectLat, selectLong);

      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<Position?> getUserCurrentLocation() async {
    if (true) {
      await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
        print("error" + error.toString());
      });
      return await Geolocator.getCurrentPosition();
    } else {
      print("No internet");
      //showDialogBox(context);
    }
  }



  _updateAddress(LatLng target) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 100), () async {
      selectLat = target.latitude;
      selectLong = target.longitude;

      placemarkFromCoordinates(selectLat, selectLong).then((value) {
        if (mounted) {
          setState(() {
            name = value[0].name.toString();
            street = value[0].street.toString();
            subLocality = value[0].subLocality.toString();
            locality = value[0].locality.toString();
            postalCode = value[0].postalCode.toString();
            administrativeArea = value[0].administrativeArea.toString();
            country = value[0].country.toString();
          });
        }
        print("valueeeee $value");
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
            body:

            Column(
    children: [
      Card(
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: SizeConfig.screenHeight * 0.02
          ),
          child: (getSearchBarLayout(SizeConfig.screenHeight, SizeConfig.screenWidth)),
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled: true,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
              },

              onCameraMove: (position) {
                _updateAddress(position.target);

              },
              // onTap: (position){
              //   _updateAddressTap(position.latitude, position.longitude);
              //   setState(() {
              //   });
              // },
            ),
            Align(alignment: Alignment.center, child: Padding(
              padding: EdgeInsets.only(
                  bottom: SizeConfig.screenHeight * 0.05
              ),
              child: Icon(Icons.location_on, size: 50, color: Colors.red,),
            ),),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight*0.09,left: SizeConfig.screenWidth*0.03,right: SizeConfig.screenWidth*0.03),
                  child: Container(
                    //  color: CommonColor.Black.withOpacity(0.3),
                    height: MediaQuery.of(context).size.height * .21,

                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                          color: Colors.black26,
                          width: 0.4,
                        ),
                        //  border: Border.all(color: Colors.black38,width: 0.5),
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [


                            name.isNotEmpty ?
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.screenHeight * 0.01,
                                  left: SizeConfig.screenWidth * 0.04
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: CommonColor.red.withOpacity(0.4),
                                    child: Image(
                                      image: AssetImage('assets/images/location.png'),
                                      color: Colors.black,
                                      height: 18,
                                    ),
                                  ),
                                  /*  Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Image(
                                image: AssetImage('assets/images/like.png'),
                                color: Colors.black,
                                height: 18,
                              ),
                            ),*/

                                  SizedBox(width: 12),
                                  Text(name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Roboto_Medium",
                                        fontSize: SizeConfig.blockSizeHorizontal * 5.4
                                    ),),
                                ],
                              ),
                            )
                                : Container(),


                            name.isNotEmpty ? Padding(
                              padding: EdgeInsets.only(

                                  left: SizeConfig.screenWidth * 0.1
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth * 0.8,
                                    color: Colors.transparent,
                                    child: Text('$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Roboto_Regular",
                                          fontSize: SizeConfig.blockSizeHorizontal * 3.50
                                      ),),
                                  ),
                                ],
                              ),
                            )
                                : const Text(""),







                          ]),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
             /* onTap: (){
             //   print("Street firstName: ${widget.firstName}");
                String selectedAddress =
                    "$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.";
                Navigator.pop(context, selectedAddress);


                Navigator.pop(context, locality);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  NewProduct(
                      ProductAddress: '$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.',
                     // BusinessOfficeAddress: '$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.',

                      lat: "$selectLat",
                      long: "$selectLong",

                      //ProfilePicture: widget.ProfileImage, firstName: widget.firstName, lastname: widget.lastname, email: widget.email, password: widget.password, cpassword: widget.cpassword, permanetAddress: widget.mobileNumber, mobileNumber: widget.mobileNumber, FrontImage: widget.frontImage, BackImage: widget.BackImage,


                    ),
                    ));*/


            onTap: () {
    String selectedAddress =
    "$name, $street, $subLocality, $locality, $postalCode, $administrativeArea, $country.";

    // Correct way to pass address back
    Navigator.pop(context, selectedAddress);


              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.07,
                    right: SizeConfig.screenWidth * 0.08,
                    bottom: SizeConfig.screenHeight * 0.02,
                  ),

                  child:
                  Container(
                      width: 370,
                      height: SizeConfig.screenHeight * 0.06,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(4, 4)),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xffFEBA69),
                            Color(0xffFE7F64),
                          ],
                        ),
                        /*   border: Border.all(
                    width: 1, color: CommonColor.APP_BAR_COLOR),*/ //Border.
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Save Address",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Roboto-Regular',
                              fontSize: SizeConfig.blockSizeHorizontal * 4.3),
                        ),



                      )),



                ),
              ),
            ),
          ],
        ),
      ),


    ],
            ),
            /* floatingActionButton: Padding(
    padding: EdgeInsets.only(bottom: SizeConfig.screenHeight*0.1),
    child: FloatingActionButton(
      onPressed: () {
        getUserCurrentLocation().then((value) async {
          // print("${value?.latitude.toString()}    ${value?.longitude.toString()}");

          selectLat = value?.latitude ?? 0.0;
          selectLong = value?.longitude ?? 0.0;

          // _markers.add(
          //     Marker(
          //         markerId:const MarkerId('2'),
          //         position: LatLng(double.parse("${value?.latitude.toString()}"), double.parse("${value?.longitude.toString()}")),
          //         infoWindow: const InfoWindow(
          //             title: 'Current'
          //         )
          //     )
          // );


          CameraPosition cameraPosition = CameraPosition(
              zoom: 18,
              target: LatLng(double.parse("${value?.latitude.toString()}"),
                  double.parse("${value?.longitude.toString()}")));

          final GoogleMapController controller = await _controller.future;

          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

          placeMark = await placemarkFromCoordinates(double.parse("${value?.latitude.toString()}"),
              double.parse("${value?.longitude.toString()}"));

          // print("placemark  ${placeMark?[0].name}  ${placeMark?[0].locality}  ${placeMark?[0].postalCode}");

          setState(() {

          });

        });
      },
      child: const Icon(Icons.my_location),
    ),
            ),*/
          );
  }

  Widget getSearchBarLayout(double parentHeight, parentWidth) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.screenWidth * .05,
          right: SizeConfig.screenWidth * .05,
          top: SizeConfig.screenHeight * 0.05),
      child: Container(
        height: SizeConfig.screenHeight * .050,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.03),
              child: const Image(
                image: AssetImage("assets/images/search.png"),
                // fit: BoxFit.contain,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.02,
                    right: SizeConfig.screenWidth * .01),
                child: GestureDetector(
                  onTap: () async {

                    _handlePressButton();

                  },
                  child: Text("Search Location",style: TextStyle(
                    fontFamily: "Roboto_Regular",
                    fontSize: SizeConfig.blockSizeHorizontal * 4.6,
                    color: CommonColor.Black,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      mode: Mode.overlay,
      apiKey: kGoogleApiKey,
      offset: 0,
      radius: 1000,
      types: [],
      strictbounds: false,
      components: [],
    );

    displayPrediction(p);
    setState(
          () {

      },
    );

  }


  Future<Null> displayPrediction(Prediction? p) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,

        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );

      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);

      double lat = detail.result.geometry!.location.lat;
      double lng = detail.result.geometry!.location.lng;

      selectLong = double.parse('$lng');
      selectLat = double.parse('$lat');

      setState(() {


        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 100), () async {

          CameraPosition cameraPosition = CameraPosition(
              zoom: 18,
              target: LatLng(selectLat, selectLong));

          final GoogleMapController controller = await _controller.future;

          controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

          // _markers.clear();
          // _markers.add(
          //     Marker(
          //         markerId:const MarkerId('2'),
          //         position: LatLng(selectLat, selectLong),
          //         infoWindow: const InfoWindow(
          //             title: 'Current'
          //         )
          //     )
          // );


          await placemarkFromCoordinates(selectLat,
              selectLong).then((value) {

            setState(() {

            });

            // print(selectLat);
            // print(selectLong);

            name = value[0].name.toString();
            street = value[0].street.toString();
            subLocality = value[0].subLocality.toString();
            locality = value[0].locality.toString();
            postalCode = value[0].postalCode.toString();
            administrativeArea = value[0].administrativeArea.toString();
            country = value[0].country.toString();

          });



          // print(placeMark);
        });

      });

    }}

}
