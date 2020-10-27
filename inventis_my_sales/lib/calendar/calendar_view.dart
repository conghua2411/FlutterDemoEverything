import 'package:flutter/material.dart';
import 'package:inventis_my_sales/calendar/model/event.dart';

class CalendarView extends StatefulWidget {
  final List<Event> events;

  final DateTime date;

  CalendarView({
    @required this.date,
    this.events,
  });

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime startMonthDate, endMonthDate;

  DateTime realStartDate;

  DateTime _currentMonth;

  DateTime _currentSelected;

  @override
  void initState() {
    super.initState();

    _currentSelected = DateTime.now();

    _currentMonth = DateTime(widget.date.year, widget.date.month);

    calDate(_currentMonth);
  }

  DateTime prevMonth(DateTime date) {
    if (date.month == 1) {
      return DateTime(date.year - 1, 12);
    } else {
      return DateTime(date.year, date.month - 1);
    }
  }

  DateTime nextMonth(DateTime date) {
    if (date.month == 12) {
      return DateTime(date.year + 1, 1);
    } else {
      return DateTime(date.year, date.month + 1);
    }
  }

  void calDate(DateTime date) {
    startMonthDate = DateTime(
      date.year,
      date.month,
    );

    endMonthDate = DateTime(
      date.year,
      date.month,
      calTotalDayOfMonth(date),
    );

    int weekDay = startMonthDate.weekday;

    realStartDate = startMonthDate.subtract(Duration(days: weekDay - 1));
  }

  bool checkLeapYear(int year) {
    if (year % 400 == 0) {
      return true;
    }

    if (year % 100 == 0) {
      return false;
    }

    if (year % 4 == 0) {
      return true;
    }
    return false;
  }

  int calTotalDayOfMonth(DateTime date) {
    List<int> dateOfM = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    List<int> dateOfMLeap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    if (checkLeapYear(date.year)) {
      return dateOfMLeap[date.month - 1];
    } else {
      return dateOfM[date.month - 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Column(
          children: [
            buildDateControl(_currentMonth),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: buildWeekDayTitle(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: buildColumn(
                  realStartDate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemWeekDayTitle({String title, bool isSunday = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          '$title',
          style: TextStyle(
            color: isSunday ? Colors.red : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buildWeekDayTitle() {
    List<String> titles = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Row(
      children: List.generate(7, (index) {
        return buildItemWeekDayTitle(
          title: titles[index],
          isSunday: index == 6,
        );
      }),
    );
  }

  Widget buildColumn(DateTime startDate) {
    List<Widget> widgets = [];

    for (int i = 0; i < 6; i++) {
      widgets.add(
        Expanded(
          child: buildWeekRow(
            startDate.add(
              Duration(days: i * 7),
            ),
          ),
        ),
      );
    }

    return Column(
      children: widgets,
    );
  }

  Widget buildWeekRow(DateTime startDate) {
    return Row(
      children: List.generate(7, (index) {
        return buildItem(
          current: startDate.add(Duration(days: index)),
          isSunday: 6 == index,
        );
      }),
    );
  }

  Widget buildItem({
    DateTime current,
    bool isSunday = false,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          setState(() {
            _currentSelected = current;
          });
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: checkSameDate(
                current,
                compare: _currentSelected,
              )
                  ? Colors.blue
                  : Colors.white,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: checkSameDate(current)
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black26,
                      )
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${current.day}',
                    style: getTextStyle(
                      current: current,
                      startDate: startMonthDate,
                      endDate: endMonthDate,
                      isSunday: isSunday,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return buildEventList(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      events: getListEventInDay(current),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Event> getListEventInDay(DateTime current) {
    return getListEvent().where((event) {
      return checkSameDate(event.time, compare: current);
    }).toList();
  }

  List<Event> getListEvent() {
    return widget.events ?? [];
  }

  bool checkSameDate(DateTime current, {DateTime compare}) {
    if (compare == null) {
      compare = DateTime.now();
    }
    return current.year == compare.year &&
        current.month == compare.month &&
        current.day == compare.day;
  }

  Widget buildEventList({
    double width,
    double height,
    List<Event> events,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: events
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                width: double.infinity,
                color: e.color,
                child: Text(
                  '$e',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  TextStyle getTextStyle({
    DateTime current,
    DateTime startDate,
    DateTime endDate,
    bool isSunday = false,
  }) {
    TextStyle style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    if (current.difference(startDate).isNegative ||
        endDate.difference(current).isNegative) {
      /// out of month date range
      if (isSunday) {
        return style.copyWith(
          color: Colors.red[200],
        );
      } else {
        return style.copyWith(
          color: Colors.black38,
        );
      }
    } else {
      /// in month date range
      if (isSunday) {
        return style.copyWith(
          color: Colors.red,
        );
      } else {
        return style;
      }
    }
  }

  Widget buildDateControl(DateTime current) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            setState(() {
              _currentMonth = prevMonth(_currentMonth);
              calDate(_currentMonth);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.chevron_left,
            ),
          ),
        ),
        Text(
          '${current.month}-${current.year}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            setState(() {
              _currentMonth = nextMonth(_currentMonth);
              calDate(_currentMonth);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.chevron_right,
            ),
          ),
        ),
      ],
    );
  }
}
