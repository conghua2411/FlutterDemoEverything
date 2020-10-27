import 'package:flutter/material.dart';
import 'package:inventis_my_sales/calendar/calendar_view.dart';
import 'package:inventis_my_sales/calendar/model/event.dart';
import 'package:rxdart/rxdart.dart';

class InventisMySale extends StatefulWidget {
  @override
  _InventisMySaleState createState() => _InventisMySaleState();
}

class _InventisMySaleState extends State<InventisMySale> {
  BehaviorSubject<bool> _bsInitWidget = BehaviorSubject();

  Future<bool> initTime() {
    return Future.delayed(Duration(seconds: 1), () {
      return true;
    });
  }

  @override
  void initState() {
    super.initState();
    initTime().then((value) {
      _bsInitWidget.add(value);
    });
  }

  @override
  void dispose() {
    _bsInitWidget.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10.0,
                    bottom: 10,
                  ),
                  child: Text(
                    'My Sales',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<bool>(
                initialData: false,
                stream: _bsInitWidget,
                builder: (context, snapshot) {
                  if (snapshot.data) {
                    return CalendarView(
                      date: DateTime.now(),
                      events: [
                        Event(
                          title: 'asdasdasd dasd asd',
                          time: DateTime.now(),
                          color: Colors.red,
                        ),
                        Event(
                          title: 'ops ops',
                          time: DateTime.now(),
                          color: Colors.blue,
                        ),
                        Event(
                          title: '1',
                          time: DateTime.now().subtract(
                            Duration(
                              days: 1,
                            ),
                          ),
                          color: Colors.blue,
                        ),
                        Event(
                          title: '2',
                          time: DateTime.now().subtract(
                            Duration(
                              days: 28,
                            ),
                          ),
                          color: Colors.amberAccent,
                        ),
                        Event(
                          title: 'asdasdasd dasd asd',
                          time: DateTime.now().add(
                            Duration(
                              days: 15,
                            ),
                          ),
                          color: Colors.red,
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
