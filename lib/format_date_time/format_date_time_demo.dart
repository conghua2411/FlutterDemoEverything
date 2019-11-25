import 'package:flutter/material.dart';

import 'date_time_format_util.dart';

class FormatDateTimeDemo extends StatefulWidget {
  @override
  State createState() => FormatDateTimeState();
}

class FormatDateTimeState extends State<FormatDateTimeDemo> {
  String formattedDate = '';
  int formattedDateIndex = 0;

  String format1 = 'MM/dd/yyyy';
  String format2 = 'yyyy/MM/dd';
  String format3 = 'dd/MM/yyyy';
  String format4 = 'yyyy/MM/dd';
  String format5 = 'yyyy-MM-dd';
  String format6 = 'dd-MM-yyyy';
  String format7 = 'dd.MM.yyyy';

  List listFormatDate = [];

  int formatTimeIndex = 0;

  String timeFormat1 = 'HH:mm';
  String timeFormat2 = 'hh:mm a';

  List listFormatTime = [];

  @override
  void initState() {
    super.initState();

    listFormatDate = [
      format1,
      format2,
      format3,
      format4,
      format5,
      format6,
      format7,
    ];

    listFormatTime = [
      timeFormat1,
      timeFormat2,
    ];

    formattedDate = format1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormatDateTimeDemo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                formattedDateIndex =
                    (formattedDateIndex + 1) % listFormatDate.length;

                formatTimeIndex = (formatTimeIndex + 1) % listFormatTime.length;
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            '${DateTimeFormatUtil.getDateFormat(DateTime.now(), listFormatTime[formatTimeIndex])}\n'
            '${DateTimeFormatUtil.getDateFormat(DateTime.now(), listFormatDate[formattedDateIndex])}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
