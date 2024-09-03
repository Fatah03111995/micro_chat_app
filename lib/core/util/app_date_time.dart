import 'package:intl/intl.dart';

class AppDateTime {
  static Function(DateTime) get toDateHourMinute =>
      DateFormat('d /MM /yyyy, kk.mm').format;
  static Function(DateTime) get toHourMinute => DateFormat('kk.mm').format;
}
