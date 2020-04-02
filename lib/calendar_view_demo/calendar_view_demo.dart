import 'package:flutter/material.dart';
import 'package:calendar_views/calendar_views.dart';

class CalendarViewDemo extends StatefulWidget {
  @override
  State createState() => CalendarViewState();
}

class CalendarViewState extends State<CalendarViewDemo> {
  Positioned _generatedTimeIndicatorBuilder(
    BuildContext context,
    ItemPosition itemPosition,
    ItemSize itemSize,
    int minuteOfDay,
  ) {
    return new Positioned(
      top: itemPosition.top,
      left: itemPosition.left,
      width: itemSize.width,
      height: itemSize.height,
      child: new Container(
        child: new Center(
          child: new Text(_minuteOfDayToHourMinuteString(minuteOfDay)),
        ),
      ),
    );
  }

  String _minuteOfDayToHourMinuteString(int minuteOfDay) {
    return "${(minuteOfDay ~/ 60).toString().padLeft(2, "0")}"
        ":"
        "${(minuteOfDay % 60).toString().padLeft(2, "0")}";
  }

  Widget _headerItemBuilder(BuildContext context, DateTime day) {
    return new Container(
      color: Colors.grey[300],
      padding: new EdgeInsets.symmetric(vertical: 4.0),
      child: new Column(
        children: <Widget>[
          new Text(
            "${(day.weekday)}",
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new Text("${day.day}"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DayViewEssentials(
          properties: DayViewProperties(days: [
            DateTime.now(),
          ]),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.grey[200],
                child: new DayViewDaysHeader(
                  headerItemBuilder: _headerItemBuilder,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: DayViewSchedule(
                    heightPerMinute: 1.0,
                    components: [
                      TimeIndicationComponent.intervalGenerated(
                        generatedTimeIndicatorBuilder:
                            _generatedTimeIndicatorBuilder,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
