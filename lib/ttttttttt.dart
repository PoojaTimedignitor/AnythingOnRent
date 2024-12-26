import 'package:flutter/material.dart';

void main() {
  runApp(dddd());
}

class dddd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SuggestionTextField(),
    );
  }
}

class SuggestionTextField extends StatefulWidget {
  @override
  _SuggestionTextFieldState createState() => _SuggestionTextFieldState();
}

class _SuggestionTextFieldState extends State<SuggestionTextField> {
  TextEditingController _controller = TextEditingController();
  List<String> _allSuggestions = [
    'apple', 'banana', 'cherry', 'date', 'elderberry', 'fig', 'grape'
  ];
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _filteredSuggestions = _allSuggestions
          .where((suggestion) => suggestion
          .toLowerCase()
          .contains(_controller.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TextField Suggestions")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Type something'),
            ),
            SizedBox(height: 10),
            if (_filteredSuggestions.isNotEmpty)
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: _filteredSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_filteredSuggestions[index]),
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
