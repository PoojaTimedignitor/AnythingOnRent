import 'package:flutter/material.dart';

void main() {
  runApp(const bbbttt());
}

class bbbttt extends StatelessWidget {
  const bbbttt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  List<String> selectedDays = [];
  final List<String> days = [
    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
  ];

  void showDaySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Days",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                ...days.map((day) {
                  bool isSelected = selectedDays.contains(day);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                        }
                      });
                      setStateBottomSheet(() {});
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(left: 15,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            day,
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.green : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Icon(Icons.check_circle, color: Colors.green, size: 14),
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multi-Select Days")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green),
                ),
              ),
              onPressed: () => showDaySelector(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Weekly Offers"),
                  Icon(Icons.arrow_drop_down, color: Colors.green),
                ],
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedDays.map((day) {
                return Chip(
                  label: Text(day, style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green,
                  deleteIcon: Icon(Icons.close, color: Colors.white),
                  onDeleted: () {
                    setState(() {
                      selectedDays.remove(day);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}