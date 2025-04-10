import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'package:http/http.dart' as http;


class RecentSearchesScreen extends StatefulWidget {
  @override
  _RecentSearchesScreenState createState() => _RecentSearchesScreenState();
}

class _RecentSearchesScreenState extends State<RecentSearchesScreen> {
  final TextEditingController searchController = TextEditingController();
  final GetStorage storage = GetStorage();
  List<String> recentSearches = [];

  bool isLoading = false;       /// new add
  String searchResult = '';      ///

  @override
  void initState() {
    super.initState();
    // Load recent searches from GetStorage
    loadRecentSearches();
  }

/// New add
  Future<void> performSearch(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse("https://backend.anythingonrent.com/categories/search/petgrooming=$query"),
        headers: {
          'Content-Type': 'application/json',
          // Add any auth headers if needed
        },
      );

      if (response.statusCode == 200) {
        final data = response.body; // You can parse JSON if needed

        // Store or use data here
        setState(() {
          searchResult = data; // You can update with parsed JSON if needed
        });


      } else {
        // Handle error
        debugPrint('Search failed: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Search error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }




  void loadRecentSearches() {
    recentSearches = storage.read<List<dynamic>>('recentSearches')?.cast<String>() ?? [];
    setState(() {});
  }

  void saveSearch(String search) {
    setState(() {
      // Check if the recent searches already contain this search
      if (!recentSearches.contains(search)) {
        // If there are already 10 items, remove the first (oldest) one
        if (recentSearches.length == 10) {
          recentSearches.removeAt(0);  // Removes the oldest search
        }
        // Add the new search at the end of the list
        recentSearches.add(search);
      }
    });
    storage.write('recentSearches', recentSearches);  // Store the updated list
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:const Color(0xffF5F6FB),

      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
        
                        child: const Icon(Icons.arrow_back)),

                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (value) {
                          saveSearch(value);
                          searchController.clear();
                          loadRecentSearches();
                        },
                        keyboardType: TextInputType.text,
                        autocorrect: true,
        
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Image(
                                image: const AssetImage("assets/images/search.png"),
                                height: SizeConfig.screenWidth * 0.07,
                              )),
                          hintText: "Search Product / Service",
                          hintStyle: TextStyle(
                            fontFamily: "Roboto_Regular",
                            fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                            color: CommonColor.SearchBar,
                            fontWeight: FontWeight.w300,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.05,
                          ),
                          border: const OutlineInputBorder(),
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              const BorderSide(color: Colors.black12, width: 1),
                              borderRadius: BorderRadius.circular(10.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.black12, width: 1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show "Recent Searches" only if the list has items
                  if (recentSearches.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Recent Searches',  // Header text
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "okra_Medium",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  const SizedBox(height: 4),

                  // Only show ListView when recentSearches is not empty
                  if (recentSearches.isNotEmpty)
                  // Wrap the ListView in a Container or use Expanded to give it size
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      color: Colors.white,// Set a specific height if needed
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: recentSearches.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),

                          title: Text(recentSearches[index],style:  TextStyle(
                            fontFamily: "Poppins-Regular",
                            color: Colors.black,
                            fontSize:
                            SizeConfig.blockSizeHorizontal *
                                4.0,
                          ),),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close,size: 20,),
                                  onPressed: () {
                                    setState(() {
                                      recentSearches.removeAt(index);
                                      storage.write('recentSearches', recentSearches);
                                    });
                                  },
                                ),
                                onTap: () {
                                  searchController.text = recentSearches[index];
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  // Optionally, add a message if no recent searches are available
                  if (recentSearches.isEmpty)
                    const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Center(
                        child: Text(
                          'No recent searches available.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  if (recentSearches.isNotEmpty)
                    SizedBox(height: 20,),
                 /* Text(
                    '   Popular Searches',  // Header text
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "okra_Medium",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Container(
                           height: 30,

                           decoration: BoxDecoration(
                             border: Border.all(color: Colors.grey,width: 0.3),
                             borderRadius: BorderRadius.circular(20),   color: Color(0xffF5F6FB),),
                           child: Center(
                             child: Text("   electronics   ", style:  TextStyle(
                               fontFamily: "Poppins-Regular",
                               color: Colors.black,
                               fontSize:
                               SizeConfig.blockSizeHorizontal *
                                   3.2,
                             ),),
                           ),
                         ),Container(
                           height: 30,

                           decoration: BoxDecoration(
                             border: Border.all(color: Colors.grey,width: 0.3),
                             borderRadius: BorderRadius.circular(20),   color: Color(0xffF5F6FB),),
                           child: Center(
                             child: Text("   Furniture   ", style:  TextStyle(
                               fontFamily: "Poppins-Regular",
                               color: Colors.black,
                               fontSize:

                               SizeConfig.blockSizeHorizontal *
                                   3.2,
                             ),),
                           ),
                         ),Container(
                           height: 30,

                           decoration: BoxDecoration(
                             border: Border.all(color: Colors.grey,width: 0.3),
                             borderRadius: BorderRadius.circular(20),   color: Color(0xffF5F6FB),),
                           child: Center(
                             child: Text("   electronics   ", style:  TextStyle(
                               fontFamily: "Poppins-Regular",
                               color: Colors.black,
                               fontSize:
                               SizeConfig.blockSizeHorizontal *
                                   3.2,
                             ),),
                           ),
                         )
                       ],
                      ),
                    ),
                  )*/
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(image: AssetImage('assets/images/anthingAds.png')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}




