/*
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class TimeSelection extends StatefulWidget {
  @override
  _TimeSelectionState createState() => _TimeSelectionState();
}

class _TimeSelectionState extends State<TimeSelection> {
  DateTime? _startTime;
  DateTime? _endTime;

  // Start time picker using flutter_datetime_picker
  void _selectStartTime(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      currentTime: _startTime ?? DateTime.now(),
      onConfirm: (date) {
        setState(() {
          _startTime = date;

          _endTime = null;
        });
      },
    );
  }

  // End time picker using flutter_datetime_picker
  void _selectEndTime(BuildContext context) {
    if (_startTime == null) return; // Ensure start time selected ho

    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      currentTime: _endTime ?? _startTime!,
      onConfirm: (date) {
        setState(() {
          _endTime = date;
        });
      },
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '';
    return MaterialLocalizations.of(context)
        .formatTimeOfDay(TimeOfDay.fromDateTime(time));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Start Time Field
        ListTile(
          title: Text("Start Time"),
          subtitle: Text(
            _startTime != null ? _formatTime(_startTime) : "Select Start Time",
          ),
          onTap: () => _selectStartTime(context),
        ),
        // End Time Field - sirf dikhaye jab start time select ho jaye
        if (_startTime != null)
          ListTile(
            title: Text("End Time"),
            subtitle: Text(
              _endTime != null ? _formatTime(_endTime) : "Select End Time",
            ),
            onTap: () => _selectEndTime(context),
          ),
      ],
    );
  }
}
*/
