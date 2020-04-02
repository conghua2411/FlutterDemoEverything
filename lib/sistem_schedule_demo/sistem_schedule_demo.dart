import 'package:flutter/material.dart';
import 'package:flutter_app/sistem_schedule_demo/schedule_screen.dart';

class SistemScheduleDemo extends StatefulWidget {
  @override
  State createState() => SistemScheduleState();
}

class SistemScheduleState extends State<SistemScheduleDemo> {
  List<ScheduleTime> listSchedule;

  @override
  void initState() {
    super.initState();

    listSchedule = List();

    listSchedule.add(
      ScheduleTime(
        title: 'alo1',
        startHour: 5,
        startMinutes: 0,
        endHour: 12,
        endMinutes: 0,
        col: 1,
      ),
    );

    listSchedule.add(
      ScheduleTime(
        title: 'alo1',
        startHour: 12,
        startMinutes: 0,
        endHour: 18,
        endMinutes: 0,
        col: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('schedule demo'),
        actions: <Widget>[
          FlatButton(
            child: Text('ay yo'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ScheduleScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 400,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 28,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amber[200],
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://cdnb.artstation.com/p/assets/images/images/014/327/751/large/alena-aenami-endless-1k.jpg?1543505168',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '3',
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '2020',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.grey[350],
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: (MediaQuery.of(context).size.width - 28) *
                                  (3 / 4),
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '1일',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '월',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 42,
                              color: Color(0xffcbcbcb),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ScheduleWidget(
                    colNumber: 3,
                    width: MediaQuery.of(context).size.width - 28,
                    height: 100 * 5.0,
                    list: [
                      ScheduleTime(
                        title: '서빙 오픈조',
                        startHour: 8,
                        startMinutes: 0,
                        endHour: 15,
                        endMinutes: 0,
                        col: 0,
                      ),
                      ScheduleTime(
                        title: '서빙 마감조',
                        startHour: 15,
                        startMinutes: 0,
                        endHour: 22,
                        endMinutes: 0,
                        col: 0,
                      ),
                      ScheduleTime(
                        title: '주방 오픈조',
                        startHour: 0,
                        startMinutes: 0,
                        endHour: 12,
                        endMinutes: 0,
                        col: 1,
                      ),
                      ScheduleTime(
                        title: '주방 미들조',
                        startHour: 12,
                        startMinutes: 0,
                        endHour: 18,
                        endMinutes: 0,
                        col: 1,
                      ),
                      ScheduleTime(
                        title: '주방 마감조',
                        startHour: 18,
                        startMinutes: 0,
                        endHour: 24,
                        endMinutes: 0,
                        col: 1,
                      ),
                      ScheduleTime(
                        title: '주간 매니저',
                        startHour: 7,
                        startMinutes: 30,
                        endHour: 15,
                        endMinutes: 0,
                        col: 2,
                      ),
                      ScheduleTime(
                        title: '주간 매니저',
                        startHour: 15,
                        startMinutes: 0,
                        endHour: 22,
                        endMinutes: 30,
                        col: 2,
                      ),
                    ],
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const MINUTES_IN_DAY = 1440;
const TIME_DIVIDER = 5;

class ScheduleWidget extends StatefulWidget {
  final List<ScheduleTime> list;

  final double height;
  final double width;

  /// number schedule can fill
  final colNumber;

  final backgroundColor;

  ScheduleWidget({
    @required this.list,
    @required this.width,
    @required this.height,
    @required this.colNumber,
    @required this.backgroundColor,
  });

  @override
  State createState() => ScheduleWidgetState();
}

class ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [];

    listWidget.add(Container(
      color: widget.backgroundColor,
      width: widget.width,
      height: widget.height,
      child: Column(
        children: List.generate(
          TIME_DIVIDER,
          (index) {
            return buildTime(
                widget.height, widget.width, widget.colNumber, index);
          },
        ),
      ),
    ));

    widget.list.forEach((scheduleTime) {
      if (scheduleTime.col < widget.colNumber) {
        listWidget.add(
          Positioned(
            left: widget.width * scheduleTime.col / (widget.colNumber + 1),
            top: ((widget.height - widget.height / TIME_DIVIDER) *
                    (scheduleTime.startTimeInMin / MINUTES_IN_DAY)) +
                widget.height / 10,
            child: Container(
              width: widget.width / (widget.colNumber + 1),
              height: ((widget.height - widget.height / TIME_DIVIDER) *
                  (scheduleTime.durationInMin / MINUTES_IN_DAY)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(69, 194, 250, 1),
                          Color.fromRGBO(49, 68, 170, 1),
                        ]),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              scheduleTime.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${scheduleTime.startHour.toString().padLeft(2, '0')}:${scheduleTime.startMinutes.toString().padLeft(2, '0')} ~ '
                              '${scheduleTime.endHour.toString().padLeft(2, '0')}:${scheduleTime.endMinutes.toString().padLeft(2, '0')}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            scheduleTime.startHour % 2 != 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Icon(
                                              Icons.person,
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        print('ScheduleWidget: level must less than colNumber \n'
            'colNumber: ${widget.colNumber}'
            ' --- schedule: ${scheduleTime.title}'
            ' --- level: ${scheduleTime.col}');
      }
    });

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Stack(
        children: listWidget,
      ),
    );
  }

//  Widget buildTime(double height) {
//    return Container(
//      height: height / TIME_DIVIDER,
//      width: double.infinity,
//      child: Center(
//        child: Container(
//          height: 1,
//          width: double.infinity,
//          color: Colors.grey[500],
//        ),
//      ),
//    );
//  }

  Widget buildTime(double height, double width, int colNumber, int index) {
    return Container(
      height: height / TIME_DIVIDER,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Center(
            child: Container(
              height: 1,
              width: width * colNumber / (colNumber + 1),
              color: Color(0xffcbcbcb),
            ),
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: Color(0xffcbcbcb),
          ),
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  height: 1,
                  width: width / (colNumber + 1) - 1,
                  color: Color(0xffcbcbcb),
                ),
              ),
              Container(
                height: double.infinity,
                width: width / (colNumber + 1) - 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      color: widget.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          '${((index / (TIME_DIVIDER - 1)) * 24).toInt().toString().padLeft(2, '0')}:00',
                          style: TextStyle(
                            color: Color(0xff979797),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScheduleTime {
  int startHour, startMinutes;
  int endHour, endMinutes;
  int col;

  String title;

  int startTimeInMin;
  int endTimeInMin;

  int durationInMin;

  ScheduleTime({
    @required this.title,
    @required this.startHour,
    @required this.startMinutes,
    @required this.endHour,
    @required this.endMinutes,
    @required this.col,
  }) {
    startTimeInMin = startHour * 60 + startMinutes;
    endTimeInMin = endHour * 60 + endMinutes;
    durationInMin = endTimeInMin - startTimeInMin;
  }
}
