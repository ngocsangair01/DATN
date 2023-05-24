import 'package:intl/intl.dart';

class MyDateConverter {
  static DateTime parseDateTime(String dateString) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.parse(dateString);
  }
}
