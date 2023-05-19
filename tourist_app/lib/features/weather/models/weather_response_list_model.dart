import 'package:flutter/cupertino.dart';

class WeatherResponseListModel {
  WeatherResponseListModel({
    this.idProvince,
    this.province,
    this.dateTime,
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.main,
    this.description,
    this.icon,
  });

  final int? idProvince;
  final String? province;
  final String? dateTime;
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? humidity;
  final String? main;
  final String? description;
  Widget? icon;

  factory WeatherResponseListModel.fromJson(Map<String, dynamic> json) {
    return WeatherResponseListModel(
      idProvince: json["idProvince"],
      province: json["province"],
      dateTime: json["dateTime"],
      temp: json["temp"],
      feelsLike: json["feelsLike"],
      tempMin: json["tempMin"],
      tempMax: json["tempMax"],
      humidity: json["humidity"],
      main: json["main"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "idProvince": idProvince,
        "province": province,
        "dateTime": dateTime,
        "temp": temp,
        "feelsLike": feelsLike,
        "tempMin": tempMin,
        "tempMax": tempMax,
        "humidity": humidity,
        "main": main,
        "description": description,
      };
}
