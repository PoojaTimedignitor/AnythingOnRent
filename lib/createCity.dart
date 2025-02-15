import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class RegisterScreenssss extends StatefulWidget {
  @override
  _RegisterScreenssssState createState() => _RegisterScreenssssState();
}

class _RegisterScreenssssState extends State<RegisterScreenssss> {
  String cityName = "Fetching city...";

  Future<void> _getCityName() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationDialog();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showLocationDialog();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showLocationDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        String fullAddress =
            "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, "
            "${place.administrativeArea}, ${place.postalCode}, ${place.country}";

        setState(() {
          cityName = fullAddress;
        });
      } else {
        setState(() {
          cityName = "Address not found";
        });
      }
    } catch (e) {
      setState(() {
        cityName = "Failed to fetch address: $e";
      });
    }
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enable Location"),
        content: Text("Please enable location services to continue."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getCityName(); // Fetch city on registration
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your City:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text(
              cityName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
          /*  ElevatedButton(
              onPressed: _getCityName,
              child: Text("Refresh Location"),
            ),*/
          ],
        ),
      ),
    );
  }
}
