import 'package:flutter/material.dart';

import 'Common_File/SizeConfig.dart';
import 'Common_File/common_color.dart';
import 'ResponseModule/getSubCatResponseModel.dart';
import 'model/dio_client.dart';

void main() {
  runApp(dddd());
}


class dddd extends StatefulWidget {

  @override
  State<dddd> createState() => _ddddState();
}

class _ddddState extends State<dddd> {

  bool isLoading = true;

  List<Data> SubCat = [];
  List<Data> filteredSubCat = [];

  void fetchSubCategories(String categoryId) async {
    try {
      Map<String, dynamic> response = await ApiClients().getAllSubCat(categoryId);

      var jsonList = getSubCategories.fromJson(response);
      setState(() {
        SubCat = jsonList.data ?? [];
        filteredSubCat = List.from(SubCat);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching categories: $e");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

      fetchSubCategories("");

    });
  }




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
  String _selectedPrimaryOption = "";
  String _selectedSecondaryOption = "";
  bool _showPrimarySuggestions = false;
  bool _showSecondarySuggestions = false;

  // Primary suggestions
  List<String> _primarySuggestions = [
    'apple',
    'banana',
    'cherry',
  ];

  Map<String, List<String>> _secondarySuggestions = {
    'apple': ['Color', 'Seed', 'Type'],
    'banana': ['Ripeness', 'Length', 'Taste'],
    'cherry': ['Size', 'Color', 'Type'],
  };

  void _onPrimaryTap() {
    setState(() {
      _showPrimarySuggestions = true;
      _showSecondarySuggestions = false; // Hide secondary list
    });
  }

  void _onPrimaryOptionTap(String option) {
    setState(() {
      _selectedPrimaryOption = option;
      _controller.text = option;
      _showPrimarySuggestions = false;
      _showSecondarySuggestions = true;
    });
  }

  void _onSecondaryOptionTap(String option) {
    setState(() {
      _selectedSecondaryOption = option;
      _controller.text = "$_selectedPrimaryOption -> $option";
      _showSecondarySuggestions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nested Suggestions")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              readOnly: true, // Prevent typing
              onTap: _onPrimaryTap, // Show primary suggestions on tap
              decoration: InputDecoration(
                isDense: true,
                hintText: 'SubCategories',
                contentPadding:
                EdgeInsets.all(10.0),
                hintStyle: TextStyle(
                  fontFamily: "Roboto_Regular",
                  color: Color(0xff7D7B7B),
                  fontSize: SizeConfig
                      .blockSizeHorizontal *
                      3.5,
                ),
                fillColor: Colors.white,
                filled: true,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width: 1.0),
                ),
                focusedBorder:
                UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width:
                      1.0), // Focused underline color and width
                ),
                enabledBorder:
                UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey[400]!,
                      width:
                      1.0), // Normal state underline
                ),
              ),
            ),
            SizedBox(height: 10),
            if (_showPrimarySuggestions || _showSecondarySuggestions)
              Container(
                height: 300,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),

                ),
                child:ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _showPrimarySuggestions
                      ? _primarySuggestions.length + 1
                      : _secondarySuggestions[_selectedPrimaryOption]!.length +
                      1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding:  EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _showPrimarySuggestions ? "  Fashion Categories" : "  Fashion Categories",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                          /*  Container(
                              height: SizeConfig.screenHeight * 0.0005,
                              color: CommonColor.SearchBar,
                            ),*/
                          ],
                        ),
                      );
                    }
                    final actualIndex = index - 1;
                    if (_showPrimarySuggestions) {

                      return Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                            minVerticalPadding: 0,
                            title: Text(_primarySuggestions[actualIndex],style: TextStyle(
                              letterSpacing: 0.5,
                              color: Colors.black,
                              fontFamily: "Montserrat_Medium",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),),
                            onTap: () => _onPrimaryOptionTap(
                                _primarySuggestions[actualIndex]),
                          ),
                          Divider( color: CommonColor.SearchBar,thickness: 0.2,),
                        ],
                      );
                    } else {
                      return ListTile(
                        title: Text(_secondarySuggestions[_selectedPrimaryOption]![actualIndex]),
                        onTap: () => _onSecondaryOptionTap(
                            _secondarySuggestions[_selectedPrimaryOption]![actualIndex]),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
