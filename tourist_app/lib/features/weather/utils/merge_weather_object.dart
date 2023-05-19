import 'dart:math';

import 'package:tourist_app/features/weather/models/weather_response_model.dart';
import 'package:tourist_app/features/weather/utils/extension.dart';

extension MergeWeather on List<CurrentWeather> {
  List<CurrentWeather> findMax() {
    //clone object tránh việc thay đổi cả 2 object
    List<CurrentWeather> _listTime = [];
    _listTime.addAll(this);
    var _temp = _listTime.map((e) => e.dateTime!.getTime()).toList().toSet();
    List<CurrentWeather> values = [];

    for (var element in _temp) {
      var weatherInTimeOfDays =
          _listTime.where((obj) => obj.dateTime!.isSameTime(element)).toList();
      double maxTemp = weatherInTimeOfDays
          .map((e) => e.tempMax ?? 0)
          .toList()
          .reduce((a, b) => max(a, b));
      double? minTemp = weatherInTimeOfDays
          .map((e) => e.tempMin ?? 0)
          .toList()
          .reduce((a, b) => min(a, b));
      values.add(
        CurrentWeather(
          dateTime: element,
          description: weatherInTimeOfDays.first.description,
          tempMax: maxTemp,
          tempMin: minTemp,
        ),
      );
    }
    return values;
  }
}
