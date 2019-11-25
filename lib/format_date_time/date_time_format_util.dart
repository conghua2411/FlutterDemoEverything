import 'package:intl/intl.dart';

class DateTimeFormatUtil {
  static String getDateFormat(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }
}