import 'package:flutter/material.dart';
import 'package:flutter_app/demoBloc/model/Student.dart';
import 'package:flutter_app/demoBloc/testBloc/TestBloc.dart';
import 'package:flutter_app/demoBloc/widget/StudentWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocScreen extends StatefulWidget {
  @override
  State createState() {
    return BlocState();
  }
}

class BlocState extends State<BlocScreen> {
  TestBloc _testBloc = TestBloc();

  void _showDialogStudent(TestBloc testBloc) {
    String studentId, studentName, studentMajor, studentSchool;

    Dialog studentDialog = Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              obscureText: true,
              onChanged: (text) {
                studentId = text;
              },
              decoration: InputDecoration(
                hintText: "student id",
                prefixIcon: Icon(Icons.star, color: Colors.red,),
                prefixText: "prefix : ",
              ),
            ),
            TextField(
              onChanged: (text) {
                studentName = text;
              },
              decoration: InputDecoration(
                hintText: "student name",
              ),
            ),
            TextField(
              onChanged: (text) {
                studentMajor = text;
              },
              decoration: InputDecoration(
                hintText: "student major",
              ),
            ),
            TextField(
              onChanged: (text) {
                studentSchool = text;
              },
              decoration: InputDecoration(
                hintText: "student school",
              ),
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    _showStudent(testBloc, studentId, studentName, studentMajor, studentSchool);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );

    showDialog(context: context, builder: (BuildContext context) => studentDialog);
  }

  void _showStudent(TestBloc testBloc, String studentId, String studentName, String studentMajor, String studentSchool) {
    final student = Student(studentId: studentId, studentName: studentName, major: studentMajor, schoolName: studentSchool);
//    BlocProvider.of<TestBloc>(context).dispatch(TestEventStudent(student: student));
    testBloc.dispatch(TestEventStudent(student: student));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<TestBloc>(bloc: _testBloc),
      ],
      child: BlocBuilder(
          bloc: _testBloc,
          builder: (_, TestState testState) {
            if (testState is TestState1) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('bloc demo'),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('empty'),
                      RaisedButton(
                        child: Text("add student"),
                        onPressed: () {
                          _testBloc.dispatch(TestEvent1(studentId: "abc123"));
                        },
                      ),
                      RaisedButton(
                        child: Text("add student 2"),
                        onPressed: () => _showDialogStudent(_testBloc),
                      ),
                    ],
                  ),
                ),
              );
            } else if (testState is TestState2) {
              return StudentWidget(testState.student);
            }
          }),
    );
  }
}
