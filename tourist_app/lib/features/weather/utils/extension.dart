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
    return "Th ${DateFormat.M().format(this)}";
  }
}

extension FormatNumber on double? {
  String formatTemp() => "${this == null ? 0 : this!.toInt()}°C";
}

extension StringFormat on String? {
  String formatSlug() => slugify(TiengViet.parse(this ?? ''), delimiter: '');
}
