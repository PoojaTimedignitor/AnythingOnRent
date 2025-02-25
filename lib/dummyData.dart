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

class RibbonShape extends StatelessWidget {
  final String text;
  final bool isHero;

  const RibbonShape({super.key, required this.text, this.isHero = false});

  @override
  Widget build(BuildContext context) {
    return isHero
        ? Hero(
      tag: text, // Hero animation for smooth transition
      child: _buildRibbon(),
    )
        : _buildRibbon();
  }

  Widget _buildRibbon() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: ClipPath(
        clipper: ArcClipper(),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(15),
          ),
          child: IntrinsicWidth(
            child: Container(
              width: 160.0,
              height: 25.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xfffd4952),
                    Color(0xfffd4952),
                    Color(0xffffa055),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(10, size.height);
    path.lineTo(0, size.height / 2);
    path.lineTo(10, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}





