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
    'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
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
            return ListView(
              children: [
                Text(
                  "Select Days for Weekly Offers",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: days.map((day) {
                    bool isSelected = selectedDays.contains(day);
                    return Container(
                      margin: EdgeInsets.zero, // 👈 Bilkul chipka diya
                      padding: EdgeInsets.zero, // 👈 Extra padding bhi hata di
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0), // 👈 Rounded bhi remove kar sakte ho agar aur chipkana hai
                        ),
                        contentPadding: EdgeInsets.zero, // 👈 ListTile ke andar bhi no padding
                        title: Text(
                          day,
                          style: TextStyle(
                            color: isSelected ? Colors.green : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.radio_button_unchecked),
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
                      ),
                    );
                  }).toList(),
                ),


                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Done"),
                )
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
