import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String studentId;
  final String studentName;
  final String major;
  final String schoolName;

  Student({this.studentId, this.studentName, this.major, this.schoolName})
      : super([studentId, studentName, major, schoolName]);

  @override
  String toString() {
    return 'Student{studentId: $studentId, studentName: $studentName, major: $major, schoolName: $schoolName}';
  }
}
