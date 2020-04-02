import 'package:flutter/material.dart';
import 'package:flutter_app/sistem_schedule_demo/sistem_schedule_demo.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  State createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 20,
              ),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.menu,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      child: Center(
                        child: Text('근무타입 선택'),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.notifications),
                            Icon(
                              Icons.settings,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    onPressed: () {
                      print('alo1234');
                    },
                  ),
                  Text('교대근무제'),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () {
                      print('alo5678');
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 35,
                ),
                child: Text('선택'),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  print('alo1234: ${constraints.maxHeight}');
                  return Container(
                    height: constraints.maxHeight - 20,
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
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  28) *
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
                            height: constraints.maxHeight,
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
