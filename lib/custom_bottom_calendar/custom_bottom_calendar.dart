import 'package:flutter/material.dart';

import 'custom_date_time_picker.dart';

class CustomBottomCalendar extends StatefulWidget {
  @override
  _CustomBottomCalendarState createState() => _CustomBottomCalendarState();
}

class _CustomBottomCalendarState extends State<CustomBottomCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FlatButton(
            child: Text('Show'),
            onPressed: () {
              _showCustomBottomDatePicker().then((date) {
                if (date != null) {
                  print('date selected: $date');
                } else {
                  print('date null');
                }
              });
//              showDatePicker(
//                  context: context,
//                  initialDate: DateTime.now(),
//                  firstDate: DateTime(2020, 3),
//                  lastDate: DateTime(2020, 5));
            },
          ),
        ),
      ),
    );
  }

  Future<DateTime> _showCustomBottomDatePicker() {
    return showModalBottomSheet<DateTime>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: CustomDateTimePicker(
            onRangeDone: (start, end) {
              Navigator.of(ctx).pop<DateTime>(start);
            },
            startDate: DateTime(DateTime.now().year - 20),
            endDate: DateTime(DateTime.now().year + 20),
            isRangeMode: true,
          ),
        );
      },
    );
  }
}
