import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(ssss());
}

class ssss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CityListScreen(),
    );
  }
}

class CityListScreen extends StatefulWidget {
  @override
  _CityListScreenState createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  // Function to fetch cities from the API
  Future<void> fetchCities() async {
    final url = 'https://example.com/getCitiesInState'; // Replace with your actual API URL
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'country': 'India',  // Sending country parameter as POST data
        'state': 'Maharashtra',  // Sending state parameter as POST data
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // If the request was successful, parse the response
      var data = json.decode(response.body);
      setState(() {
        cities = List<String>.from(data['data']);
      });
    } else {
      // If the request failed
      throw Exception('Failed to load cities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cities of Maharashtra'),
      ),
      body: cities.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]),
          );
        },
      ),
    );
  }
}