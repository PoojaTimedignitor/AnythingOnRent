/*
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  runApp(const searchbarrr());
}

class searchbarrr extends StatelessWidget {
  const searchbarrr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zomato-style Search',
      home: SearchBarScreen(),
    );
  }
}

class SearchBarScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final GetStorage storage = GetStorage();

  SearchBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Bar'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            // Navigate to the Recent Searches screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecentSearchesScreen()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search for restaurants, dishes...',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecentSearchesScreen extends StatefulWidget {
  @override
  _RecentSearchesScreenState createState() => _RecentSearchesScreenState();
}

class _RecentSearchesScreenState extends State<RecentSearchesScreen> {
  final TextEditingController searchController = TextEditingController();
  final GetStorage storage = GetStorage();
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    // Load recent searches from GetStorage
    loadRecentSearches();
  }

  void loadRecentSearches() {
    recentSearches = storage.read<List<dynamic>>('recentSearches')?.cast<String>() ?? [];
    setState(() {});
  }

  void saveSearch(String search) {
    if (search.isNotEmpty && !recentSearches.contains(search)) {
      recentSearches.add(search);
      storage.write('recentSearches', recentSearches);
    }
  }

  void clearRecentSearches() {
    storage.remove('recentSearches');
    setState(() {
      recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Searches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: clearRecentSearches, // Clear all recent searches
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onSubmitted: (value) {
                saveSearch(value);
                searchController.clear();
                loadRecentSearches();
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(recentSearches[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          recentSearches.removeAt(index);
                          storage.write('recentSearches', recentSearches);
                        });
                      },
                    ),
                    onTap: () {
                      // Handle tap on a recent search
                      searchController.text = recentSearches[index];
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class LeftRibbonBanner extends StatelessWidget {
  final String text;

  const LeftRibbonBanner({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110,
      left: -60, // Ribbon thoda bahar aayega
      child: Stack(
        children: [
          // Triangle (Ribbon ka pointed edge)
          Transform.rotate(
            angle: -0.78, // -45 degrees
            child: Container(
              width: 120,
              height: 120,
              color: Colors.red.shade700,
            ),
          ),
          // Main Ribbon
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




