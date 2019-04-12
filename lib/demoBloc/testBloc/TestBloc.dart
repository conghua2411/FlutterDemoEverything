import 'package:equatable/equatable.dart';
import 'package:flutter_app/demoBloc/model/Student.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'dart:async';

abstract class TestEvent extends Equatable {
  TestEvent([List props = const []]) : super(props);
}

class TestEvent1 extends TestEvent {
  final String studentId;

  TestEvent1({@required this.studentId})
      : assert(studentId != null),
        super([studentId]);
}

class TestEventEmpty extends TestEvent {}

class TestEventStudent extends TestEvent {
  final Student student;

  TestEventStudent({@required this.student})
      : assert(student != null),
        super([student]);
}

abstract class TestState extends Equatable {
  TestState([List props = const []]) : super(props);
}

class TestState1 extends TestState {}

class TestState2 extends TestState {
  final Student student;

  TestState2({@required this.student})
      : assert(student != null),
        super([student]);
}

class TestBloc extends Bloc<TestEvent, TestState> {
  @override
  TestState get initialState {
    return TestState1();
  }

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    if (event is TestEvent1) {
      final Student student = await getStudent(event.studentId);
      yield TestState2(student: student);
    } else if (event is TestEventStudent) {
      final Student student = await getStudent2(event.student);
      yield TestState2(student: student);
    } else {
      yield TestState1();
    }
  }

  getStudent(String studentId) {
    return Student(
        studentId: studentId,
        studentName: studentId + "name",
        major: studentId + "major",
        schoolName: studentId + "school");
  }

  getStudent2(Student student) {
    return Student(
        studentId: student.studentId + "_student2",
        studentName: student.studentName + "_student2",
        major: student.major + "_student2",
        schoolName: student.schoolName + "_student2");
  }
}
