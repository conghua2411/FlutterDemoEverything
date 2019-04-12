import 'package:flutter/material.dart';
import 'package:flutter_app/demoBloc/model/Student.dart';
import 'package:flutter_app/demoBloc/testBloc/TestBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentWidget extends StatefulWidget {

  final Student student;

  StudentWidget(this.student);

  @override
  State createState() {
    return StudentState(student);
  }
}

class StudentState extends State<StudentWidget> {

  final Student student;

  StudentState(this.student);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('student info'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('studentId : ${student.studentId}'),
            Text('studentName : ${student.studentName}'),
            Text('studentMajor : ${student.major}'),
            Text('studentSchool : ${student.schoolName}'),
            RaisedButton(
              onPressed: () {
                BlocProvider.of<TestBloc>(context).dispatch(TestEventEmpty());
              },
              child: Text("back"),
            )
          ],
        ),
      ),
    );
  }
}