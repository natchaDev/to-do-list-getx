import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateTimeString(String dateFormat) {
    return DateFormat(dateFormat).format(this);
  }
}
