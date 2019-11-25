import 'dart:async';

import 'package:intl/intl.dart';

class DateTimeManager {
  String currentPattern = 'MM/dd/yyyy';

  StreamController<String> patternDateChange = StreamController.broadcast();

  changePatternDate(String pattern) {
    currentPattern = pattern;
    patternDateChange.add(pattern);
  }

  String getFormatTime(DateTime date) => DateFormat(currentPattern).format(date);

  dispose() {
    patternDateChange.close();
  }
}