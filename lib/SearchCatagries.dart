import 'package:anything/ResponseModule/getAllCatList.dart';
import 'package:flutter/material.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'model/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentSearchesScreen extends StatefulWidget {
  const RecentSearchesScreen({super.key});

  @override
  State<RecentSearchesScreen> createState() => _RecentSearchesScreenState();
}

class _RecentSearchesScreenState extends State<RecentSearchesScreen> {
  List<Data> items = [];
  bool isLoading = true;
  List<String> recentSearches = []; // To store recent searches
  List<String> filteredItems = [];  // To store filtered categories based on search

  final List<String> catagriesImage = [
    'assets/images/cattwo.png',
    'assets/images/catthree.png',
    'assets/images/catfour.png',
    'assets/images/catone.png',
    'assets/images/catthree.png',
    'assets/images/cattwo.png',
    'assets/images/catone.png',
    'assets/images/cattwo.png',
    'assets/images/catthree.png',
    'assets/images/catthree.png',
    'assets/images/catthree.png',
    'assets/images/catfour.png',
    'assets/images/catfour.png',
    'assets/images/cattwo.png'
  ];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
    loadRecentSearches();
  }

  // Fetch Categories data
  void fetchCategories() async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllCat();
      var jsonList = GetAllCategoriesList.fromJson(response);
      setState(() {
        items = jsonList.data ?? [];
        filteredItems = items.map((e) => e.categoryName.toString()).toList(); // Initial filter with all categories
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching categories: $e");
    }
  }

  // Load recent searches from SharedPreferences
  void loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recent_searches') ?? [];
    });
  }

  // Add a search term to recent searches and save it
  void addToRecentSearch(String categoryName) async {
    if (!recentSearches.contains(categoryName)) {
      setState(() {
        recentSearches.insert(0, categoryName); // Add to the top
      });
      if (recentSearches.length > 5) {
        recentSearches.removeLast(); // Limit to 5 recent searches
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('recent_searches', recentSearches); // Save to storage
    }
  }

  // Filter items based on the search query
  void filterSearchResults(String query) {
    List<String> filtered = items
        .where((category) =>
        category.categoryName!.toLowerCase().contains(query.toLowerCase()))
        .map((e) => e.categoryName.toString())
        .toList();
    setState(() {
      filteredItems = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: SizeConfig.screenHeight * 0.96,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                  height: SizeConfig.screenHeight * 0.9,
                  child: AllCatagriesList(SizeConfig.screenHeight, SizeConfig.screenWidth))
            ],
          ),
        ),
      ),
    );
  }

  Widget AllCatagriesList(double parentheight, double parentWidth) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: EdgeInsets.only(top: parentheight * 0.07),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search for a category...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (query) {
                    filterSearchResults(query);
                  },
                ),
              ),

              // Recent Searches Section
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Searches",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: CommonColor.Black,
                      ),
                    ),
                    SizedBox(height: 10),
                    recentSearches.isEmpty
                        ? Text(
                      "No recent searches",
                      style: TextStyle(
                        color: CommonColor.gray,
                      ),
                    )
                        : Column(
                      children: recentSearches.map((search) {
                        return ListTile(
                          title: Text(search),
                          onTap: () {
                            // Navigate to the category on search click
                            Navigator.pop(context, search);
                            _searchController.text = search; // Fill search bar with the selected search
                            filterSearchResults(search); // Filter the categories
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Categories Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: filteredItems.isNotEmpty
                      ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 11.0,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          addToRecentSearch(filteredItems[index]);
                          Navigator.pop(context, filteredItems[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 0.0, right: 5.0, top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff9584D6), width: 0.5),
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      catagriesImage[index],
                                      width: 45,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  filteredItems[index],
                                  style: TextStyle(
                                    color: CommonColor.Black,
                                    fontFamily: "Roboto_Regular",
                                    fontSize: SizeConfig.blockSizeHorizontal * 3.2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : Column(
                    children: [
                      Icon(Icons.search_sharp, color: CommonColor.noResult, size: 50),
                      Text(
                        "No results found",
                        style: TextStyle(
                          color: CommonColor.Black,
                          fontFamily: "Roboto_Regular",
                          fontSize: SizeConfig.blockSizeHorizontal * 4.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: SizeConfig.screenWidth * 0.6,
                        child: Text(
                          "We couldn't find what you searched for. Try searching again.",
                          style: TextStyle(
                            color: CommonColor.gray,
                            fontFamily: "Roboto_Regular",
                            fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
