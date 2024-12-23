import 'package:flutter/material.dart';

class FaintContainerAndTextField extends StatefulWidget {
  @override
  _FaintContainerAndTextFieldState createState() =>
      _FaintContainerAndTextFieldState();
}

class _FaintContainerAndTextFieldState
    extends State<FaintContainerAndTextField> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container aur TextField Faint"),
      ),
      body: Column(
        children: [
          // Category Dropdown Selector
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: Text("Category Chunein"),
              items: ["Category 1", "Category 2", "Category 3"]
                  .map((category) => DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
          ),

          // Faint Container
          Opacity(
            opacity: selectedCategory == null ? 0.5 : 1.0, // Faint effect
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  selectedCategory == null
                      ? "Category select karein."
                      : "Category selected: $selectedCategory",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Faint TextField
          Opacity(
            opacity: selectedCategory == null ? 0.5 : 1.0, // Faint effect
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                enabled: selectedCategory != null, // Disable if no category
                decoration: InputDecoration(
                  labelText: "Yaha Text Likhein",
                  hintText: "Category ke bina enable nahi hoga",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
