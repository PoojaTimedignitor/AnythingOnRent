import 'package:flutter/material.dart';

void main() => runApp(search());

class search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> itemList = [
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Fig",
    "Grape",
    "Mango"
  ];
  List<String> filteredList = [];
  bool isSearching = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    filteredList = itemList;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredList = itemList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text("Search Bar Example")
            : TextField(
          onChanged: updateSearchQuery,
          decoration: InputDecoration(
            hintText: "Search...",
            border: InputBorder.none,
          ),
          autofocus: true,
        ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {

                  filteredList = itemList;
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredList[index]),
          );
        },
      ),
    );
  }
}
