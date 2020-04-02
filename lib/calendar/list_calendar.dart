import 'package:flutter/material.dart';
import 'package:flutter_app/calendar/list/calendar_carousel.dart';

class ListCalendar extends StatefulWidget {
  @override
  _ListCalendarState createState() => _ListCalendarState();
}

class _ListCalendarState extends State<ListCalendar> {
  List<Map<String, dynamic>> listMapRoute = List();

  @override
  void initState() {
    super.initState();

    listMapRoute.add({
      'flutter_calendar_carousel': MaterialPageRoute(
        builder: (context) => CalendarCarouselDemo(),
      )
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildCalendarItem(listMapRoute[index]);
          },
          itemCount: listMapRoute.length,
        ),
      ),
    );
  }

  Widget _buildCalendarItem(Map<String, dynamic> listMapRoute) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(listMapRoute[listMapRoute.keys.first]);
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(listMapRoute.keys.first),
            ),
          ),
        ),
      ),
    );
  }
}
