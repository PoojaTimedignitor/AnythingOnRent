import 'package:flutter/material.dart';

void main() => runApp(widgetss());

class widgetss extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FrequencySelection(),
    );
  }
}

class FrequencySelection extends StatefulWidget {
  @override
  _FrequencySelectionState createState() => _FrequencySelectionState();
}

class _FrequencySelectionState extends State<FrequencySelection> {
  // Boolean variables for each checkbox
  bool perDay = false;
  bool perHour = false;
  bool perMonth = false;
  bool perWeek = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Frequency')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckboxListTile(
              title: Text('Per Day'),
              value: perDay,
              onChanged: (bool? value) {
                setState(() {
                  perDay = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Per Hour'),
              value: perHour,
              onChanged: (bool? value) {
                setState(() {
                  perHour = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Per Month'),
              value: perMonth,
              onChanged: (bool? value) {
                setState(() {
                  perMonth = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Per Week'),
              value: perWeek,
              onChanged: (bool? value) {
                setState(() {
                  perWeek = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic for what to do with selected checkboxes
                print('Per Day: $perDay');
                print('Per Hour: $perHour');
                print('Per Month: $perMonth');
                print('Per Week: $perWeek');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
