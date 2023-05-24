import 'package:intl/intl.dart';
import 'package:slugify/slugify.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:tourist_app/cores/values/strings.dart';

extension CompareTime on DateTime {
  DateTime getTime() {
    return DateTime(year, month, day);
  }

  bool isAfterTime(DateTime other) {
    return getTime().isAfter(other.getTime());
  }

  bool isSameTime(DateTime other) {
    return getTime().isAtSameMomentAs(other.getTime());
  }

  bool isBeforeTime(DateTime other) {
    return getTime().isBefore(other.getTime());
  }
}

extension FormatDate on DateTime {
  String get dateString {
    if (isBeforeTime(DateTime.now()) &&
        difference(DateTime.now().getTime()).inDays == -1) {
      return AppStr.before;
    }
    if (isAfterTime(DateTime.now()) &&
        difference(DateTime.now().getTime()).inDays == 1) {
      return AppStr.tomorrowDay;
    }
    if (isSameTime(DateTime.now().getTime())) {
      return AppStr.now;
    }
    String month = DateFormat.M().format(this);
    switch (month) {
      case "1":
        month = "Jan";
        break;
      case "2":
        month = "Feb";
        break;
      case "3":
        month = "Mar";
        break;
      case "4":
        month = "Apr";
        break;
      case "5":
        month = "May";
        break;
      case "6":
        month = "Jun";
        break;
      case "7":
        month = "Jul";
        break;
      case "8":
        month = "Aug";
        break;
      case "9":
        month = "Sep";
        break;
      case "10":
        month = "Oct";
        break;
      case "11":
        month = "Nov";
        break;
      case "12":
        month = "Dec";
        break;
    }
    return month;
  }
}

extension FormatNumber on double? {
  String formatTemp() => "${this == null ? 0 : this!.toInt()}°C";
}

extension StringFormat on String? {
  String formatSlug() => slugify(TiengViet.parse(this ?? ''), delimiter: '');
}
