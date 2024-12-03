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

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isEditing = false; // Controls edit mode
  String profileImage =
      "https://res.cloudinary.com/duqvffqxj/image/upload/v1733199289/ijndaqgyxlsu0lxmqqfy.jpg"; // Example profile image
  String firstname = "John"; // Example data
  String phoneNumber = "8268849874";
  String email = "john.doe@example.com";
  String address = "123 Main Street, City, Country";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with existing data
    nameController.text = firstname;
    phoneController.text = phoneNumber;
    emailController.text = email;
    addressController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 35.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 32.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: (profileImage.isNotEmpty)
                          ? NetworkImage(profileImage)
                          : AssetImage('assets/images/profiless.png')
                      as ImageProvider,
                    ),
                  ),
                  if (isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Handle camera icon tap here
                          print("Camera Icon Tapped");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing; // Toggle editing mode
                  });
                },
                child: Text(isEditing ? "Cancel" : "Edit"),
              ),
            ),
            SizedBox(height: 20),
            isEditing
                ? _buildEditForm()
                : _buildUserInfo(), // Show either edit form or user info
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.96,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow("Name", firstname),
            SizedBox(height: 10),
            _buildInfoRow("Phone Number", phoneNumber),
            SizedBox(height: 10),
            _buildInfoRow("Email", email),
            SizedBox(height: 10),
            _buildInfoRow("Address", address),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return /*Row(
      children: [
        Text(
          "$label: ",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );*/

      Padding(
        padding: EdgeInsets.all(16.0),
        child:  Row(
          children: [
            Text("$label :",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "okra_Medium",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(width: 20),
            Flexible(
              flex: 2, // Adjusts space for the value
              child: Text(
                value, // Replace with actual user name
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Montserrat-Medium",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

      );

  }

  Widget _buildEditForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Phone Number"),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(labelText: "Address"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                firstname = nameController.text;
                phoneNumber = phoneController.text;
                email = emailController.text;
                address = addressController.text;
                isEditing = false; // Exit edit mode
              });
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
