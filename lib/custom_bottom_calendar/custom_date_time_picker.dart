import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class CustomDateTimePicker extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  final Function(DateTime) onDone;
  final Function(DateTime start, DateTime end) onRangeDone;
  final bool isRangeMode;

  CustomDateTimePicker({
    this.onDone,
    this.onRangeDone,
    @required this.startDate,
    @required this.endDate,
    this.isRangeMode = false,
  }) : assert((isRangeMode == true && onRangeDone != null) ||
            (isRangeMode == false && onDone != null));

  @override
  _CustomDateTimePickerState createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker>
    with TickerProviderStateMixin {
  AnimationController _fadeAnimationController;
  Animation _fadeAnimation;

  PageController _pageController;

  DateTime _now;

  BehaviorSubject<DateTime> _currentSelectedDate;

  /// range mode
  BehaviorSubject<DateTime> _currentStartDate;
  BehaviorSubject<DateTime> _currentEndDate;

  BehaviorSubject<bool> _bsIsPickerYearMode;

  int calculateMonth(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;
  }

  @override
  void initState() {
    super.initState();

    _bsIsPickerYearMode = BehaviorSubject();

    _currentSelectedDate = BehaviorSubject();

    /// range mode
    _currentStartDate = BehaviorSubject();
    _currentEndDate = BehaviorSubject();

    _now = DateTime.now();

    _pageController =
        PageController(initialPage: calculateMonth(widget.startDate, _now));

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );

    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_fadeAnimationController);
  }

  @override
  void dispose() {

    _bsIsPickerYearMode.close();

    _currentSelectedDate.close();

    _currentStartDate.close();
    _currentEndDate.close();

    _pageController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Pick A Date',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (widget.isRangeMode) {
                      if (_currentStartDate.value != null &&
                          _currentEndDate.value != null) {
                        widget.onRangeDone(
                            _currentStartDate.value, _currentEndDate.value);
                      } else {
                        print('please select date');
                      }
                    } else {
                      widget.onDone(_currentSelectedDate.value);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff007aff),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: _bsIsPickerYearMode,
          builder: (context, snapshot) {
            if (snapshot.data) {
              /// pick year
              return _buildYearPicker();
            } else {
              return _buildCustomPicker();
            }
          }
        ),
        widget.isRangeMode
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                        ),
                        child: Text(
                          'Date range',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                            color: Color(0xffb3b3b3),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  StreamBuilder<DateTime>(
                                      stream: _currentStartDate,
                                      builder: (context, snapshot) {
                                        return Text(
                                          snapshot.hasData
                                              ? '${snapshot.data.year}.${snapshot.data.month.toString().padLeft(2, '0')}.${snapshot.data.day.toString().padLeft(2, '0')} ~ '
                                              : '',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xff000000),
                                            height: 1.3,
                                          ),
                                        );
                                      }),
                                  StreamBuilder<DateTime>(
                                    stream: _currentEndDate,
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData
                                            ? '${snapshot.data.year}.${snapshot.data.month.toString().padLeft(2, '0')}.${snapshot.data.day.toString().padLeft(2, '0')}'
                                            : '',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Color(0xff000000),
                                          height: 1.3,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                _currentStartDate.add(null);
                                _currentEndDate.add(null);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  'Clear dates',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                    color: Color(0xff007aff),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _buildYearPicker() {
    return Container(
      height: 70 + ((MediaQuery.of(context).size.width - 40) / 7) * 8,
    );
  }

  Widget _buildCustomPicker() {
    return Container(
      height: 70 + ((MediaQuery.of(context).size.width - 40) / 7) * 8,
      child: NotificationListener<ScrollStartNotification>(
        onNotification: (_) {
          _fadeAnimationController.forward();
          return false;
        },
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (_) {
            _fadeAnimationController.reverse();
            return false;
          },
          child: PageView.builder(
            controller: _pageController,
            itemCount: calculateMonth(widget.startDate, widget.endDate) + 1,
            itemBuilder: (ctx, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20,
                    ),
                    child: Container(
                      height: 70,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 70,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    '${getCurrentDate(widget.startDate, index).year}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                      height: 1.35,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${getMonth(getCurrentDate(widget.startDate, index))}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff000000),
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 0,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: InkWell(
                                onTap: () {
                                  _pageController.previousPage(
                                      duration: Duration(milliseconds: 100),
                                      curve: Curves.ease);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 0,
                            child: FadeTransition(
                              opacity: _fadeAnimation,
                              child: InkWell(
                                onTap: () {
                                  _pageController.nextPage(
                                      duration: Duration(milliseconds: 250),
                                      curve: Curves.ease);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: _buildMonth(
                        getCurrentDate(widget.startDate, index).year,
                        getCurrentDate(widget.startDate, index).month),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  DateTime getCurrentDate(DateTime monthDate, int monthsToAdd) {
    return DateTime(
        monthDate.year + monthsToAdd ~/ 12, monthDate.month + monthsToAdd % 12);
  }

  String getMonth(DateTime date) => DateFormat("MMMM").format(date);

  List<int> listDate = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  List<int> listDateLeaf = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  int _getTotalDayInMonth(int year, int month) {
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
      return listDateLeaf[month - 1];
    } else {
      return listDate[month - 1];
    }
  }

  Widget _buildMonth(int year, int month) {
    DateTime startDay = DateTime(year, month, 1);
    DateTime endDay = DateTime(year, month, _getTotalDayInMonth(year, month));
    List<Widget> listWidget = [];

    for (int i = 1;
        i <= _getTotalDayInMonth(year, month) + startDay.weekday - 1;
        i = i + 7) {
      List<int> days = [
        generateNumber(
            i - startDay.weekday + 1, _getTotalDayInMonth(year, month)),
        generateNumber(
            i + 1 - startDay.weekday + 1, _getTotalDayInMonth(year, month)),
        generateNumber(
            i + 2 - startDay.weekday + 1, _getTotalDayInMonth(year, month)),
        generateNumber(
            i + 3 - startDay.weekday + 1, _getTotalDayInMonth(year, month)),
        generateNumber(
            i + 4 - startDay.weekday + 1, _getTotalDayInMonth(year, month)),
        generateNumber(
            i + 5 - startDay.weekday + 1, _getTotalDayInMonth(year, month)),
        generateNumber(
            i + 6 - startDay.weekday + 1, _getTotalDayInMonth(year, month)),
      ];

      if (widget.isRangeMode) {
        listWidget.add(_buildDateRowRangeMode(days, year, month));
      } else {
        listWidget.add(_buildDateRow(days, year, month));
      }
    }

    return Column(
      children: <Widget>[
        Row(
          children: ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'].map((s) {
            return Expanded(
              child: Container(
                height: (MediaQuery.of(context).size.width - 40) / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    s,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffb3b3b3),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: listWidget,
        ),
      ],
    );
  }

  int generateNumber(int num, int max) {
    if (num <= 0 || num > max) {
      return null;
    } else {
      return num;
    }
  }

  Widget _buildDateRow(List<int> list, int year, int month,
      {TextStyle textStyle, BoxDecoration boxDecoration}) {
    return Row(
      children: list.map((s) {
        return Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: s != null
                ? () {
                    _currentSelectedDate.add(DateTime(year, month, s));
                  }
                : null,
            child: StreamBuilder<DateTime>(
              initialData: null,
              stream: _currentSelectedDate,
              builder: (context, snapshot) {
                return Container(
                  height: (MediaQuery.of(context).size.width - 40) / 7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: double.infinity,
                          width: 6,
                        ),
                        Expanded(
                          child: Container(
                            decoration: s != null &&
                                    snapshot.hasData &&
                                    checkSameDate(snapshot.data, year, month, s)
                                ? BoxDecoration(
                                    color: Color(0xff007aff),
                                    borderRadius: BorderRadius.circular(40),
                                  )
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                            child: Center(
                              child: Text(
                                s == null ? '' : '$s',
                                style: s != null &&
                                        snapshot.hasData &&
                                        checkSameDate(
                                            snapshot.data, year, month, s)
                                    ? TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffffffff),
                                      )
                                    : s != null &&
                                            _now.year == year &&
                                            _now.month == month &&
                                            s == _now.day
                                        ? TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff007aff),
                                          )
                                        : textStyle != null
                                            ? textStyle
                                            : TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff000000),
                                              ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: 6,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateRowRangeMode(List<int> list, int year, int month,
      {TextStyle textStyle, BoxDecoration boxDecoration}) {
    List<Widget> listWidget = [];
    for (int i = 0; i < list.length; i++) {
      listWidget.add(_buildItemDateRangeModel(i, list[i], year, month,
          textStyle: textStyle, boxDecoration: boxDecoration));
    }

    return Row(
      children: listWidget,
    );
  }

  Widget _buildItemDateRangeModel(int index, int s, year, month,
      {TextStyle textStyle, BoxDecoration boxDecoration}) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: s != null
            ? () {
                if (_currentStartDate.value == null) {
                  _currentStartDate.add(DateTime(year, month, s));
                } else if (_currentEndDate.value == null &&
                    _currentStartDate.value
                            .difference(DateTime(year, month, s))
                            .inDays <
                        0) {
                  _currentEndDate.add(DateTime(year, month, s));
                } else {
                  print('cannot select new one');
                }
              }
            : null,
        child: StreamBuilder<DateTime>(
          initialData: null,
          stream: _currentStartDate,
          builder: (context, snapshotStart) {
            return StreamBuilder<DateTime>(
              initialData: null,
              stream: _currentEndDate,
              builder: (context, snapshotEnd) {
                return Container(
                  height: (MediaQuery.of(context).size.width - 40) / 7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: double.infinity,
                          width: 6,
                          decoration: s != null &&
                                  snapshotStart.hasData &&
                                  snapshotEnd.hasData
                              ? checkSameDate(
                                      snapshotStart.data, year, month, s)
                                  ? BoxDecoration()
                                  : checkSameDate(
                                          snapshotEnd.data, year, month, s)
                                      ? BoxDecoration(
                                          color: Color(0xffe6f2ff),
                                        )
                                      : calDiffDate(
                                                      snapshotStart.data,
                                                      DateTime(
                                                          year, month, s)) >
                                                  0 &&
                                              calDiffDate(
                                                      DateTime(year, month, s),
                                                      snapshotEnd.data) >
                                                  0
                                          ? BoxDecoration(
                                              color: index == 0 || s == 1
                                                  ? Colors.transparent
                                                  : Color(0xffe6f2ff),
                                            )
                                          : BoxDecoration()
                              : BoxDecoration(),
                        ),
                        Expanded(
                          child: Container(
                            decoration: s != null &&
                                    snapshotStart.hasData &&
                                    snapshotEnd.hasData
                                ? checkSameDate(
                                        snapshotStart.data, year, month, s)
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          bottomLeft: Radius.circular(40),
                                        ),
                                        color: Color(0xffe6f2ff),
                                      )
                                    : checkSameDate(
                                            snapshotEnd.data, year, month, s)
                                        ? BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              bottomRight: Radius.circular(40),
                                            ),
                                            color: Color(0xffe6f2ff),
                                          )
                                        : calDiffDate(
                                                        snapshotStart.data,
                                                        DateTime(
                                                            year, month, s)) >
                                                    0 &&
                                                calDiffDate(
                                                        DateTime(
                                                            year, month, s),
                                                        snapshotEnd.data) >
                                                    0
                                            ? index == 0 || s == 1
                                                ? BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(40),
                                                      bottomLeft:
                                                          Radius.circular(40),
                                                    ),
                                                    color: Color(0xffe6f2ff),
                                                  )
                                                : index == 6 ||
                                                        s ==
                                                            _getTotalDayInMonth(
                                                                year, month)
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  40),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  40),
                                                        ),
                                                        color:
                                                            Color(0xffe6f2ff),
                                                      )
                                                    : BoxDecoration(
                                                        color:
                                                            Color(0xffe6f2ff),
                                                      )
                                            : BoxDecoration()
                                : BoxDecoration(),
                            child: Container(
                              decoration: s != null &&
                                      ((snapshotStart.hasData &&
                                              checkSameDate(snapshotStart.data,
                                                  year, month, s)) ||
                                          (snapshotEnd.hasData &&
                                              checkSameDate(snapshotEnd.data,
                                                  year, month, s)))
                                  ? BoxDecoration(
                                      color: Color(0xff007aff),
                                      borderRadius: BorderRadius.circular(40),
                                    )
                                  : BoxDecoration(),
                              child: Center(
                                child: Text(
                                  s == null ? '' : '$s',
                                  style: s != null &&
                                          ((snapshotStart.hasData &&
                                                  checkSameDate(
                                                      snapshotStart.data,
                                                      year,
                                                      month,
                                                      s)) ||
                                              (snapshotEnd.hasData &&
                                                  checkSameDate(
                                                      snapshotEnd.data,
                                                      year,
                                                      month,
                                                      s)))
                                      ? TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffffffff),
                                        )
                                      : s != null &&
                                              _now.year == year &&
                                              _now.month == month &&
                                              s == _now.day
                                          ? TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff007aff),
                                            )
                                          : textStyle != null
                                              ? textStyle
                                              : TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff000000),
                                                ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: 6,
                          decoration: s != null &&
                                  snapshotStart.hasData &&
                                  snapshotEnd.hasData
                              ? checkSameDate(
                                      snapshotStart.data, year, month, s)
                                  ? BoxDecoration(
                                      color: Color(0xffe6f2ff),
                                    )
                                  : checkSameDate(
                                          snapshotEnd.data, year, month, s)
                                      ? BoxDecoration()
                                      : calDiffDate(
                                                      snapshotStart.data,
                                                      DateTime(
                                                          year, month, s)) >
                                                  0 &&
                                              calDiffDate(
                                                      DateTime(year, month, s),
                                                      snapshotEnd.data) >
                                                  0
                                          ? BoxDecoration(
                                              color: index == 6 ||
                                                      s ==
                                                          _getTotalDayInMonth(
                                                              year, month)
                                                  ? Colors.transparent
                                                  : Color(0xffe6f2ff),
                                            )
                                          : BoxDecoration()
                              : BoxDecoration(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  bool checkSameDate(DateTime dateTime, int year, int month, int day) {
    return dateTime.year == year &&
        dateTime.month == month &&
        dateTime.day == day;
  }

  int calDiffDate(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }
}
