class WeatherResponseModel {
  WeatherResponseModel({
    this.idProvince,
    this.nameProvince,
    this.currentWeather,
    required this.weatherInformationList,
  });

  int? idProvince;
  String? nameProvince;
  CurrentWeather? currentWeather;
  List<CurrentWeather> weatherInformationList;

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return WeatherResponseModel(
      idProvince: json["idProvince"],
      nameProvince: json["nameProvince"],
      currentWeather: json["currentWeather"] == null
          ? null
          : CurrentWeather.fromJson(json["currentWeather"]),
      weatherInformationList: json["weatherInformationList"] == null
          ? []
          : List<CurrentWeather>.from(json["weatherInformationList"]!
              .map((x) => CurrentWeather.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "idProvince": idProvince,
        "nameProvince": nameProvince,
        "currentWeather": currentWeather?.toJson(),
        "weatherInformationList":
            weatherInformationList.map((x) => x.toJson()).toList(),
      };
}

class CurrentWeather {
  CurrentWeather({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.humidity,
    this.main,
    this.description,
    this.dateTime,
  });

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? humidity;
  String? main;
  String? description;
  DateTime? dateTime;

  factory CurrentWeather.copyWith(CurrentWeather otherWeather) {
    return CurrentWeather(
      temp: otherWeather.temp,
      feelsLike: otherWeather.feelsLike,
      tempMin: otherWeather.tempMin,
      tempMax: otherWeather.tempMax,
      humidity: otherWeather.humidity,
      main: otherWeather.main,
      description: otherWeather.description,
      dateTime: otherWeather.dateTime,
    );
  }

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temp: json["temp"],
      feelsLike: json["feelsLike"],
      tempMin: json["tempMin"],
      tempMax: json["tempMax"],
      humidity: json["humidity"],
      main: json["main"],
      description: json["description"],
      dateTime: DateTime.tryParse(json["dateTime"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feelsLike": feelsLike,
        "tempMin": tempMin,
        "tempMax": tempMax,
        "humidity": humidity,
        "main": main,
        "description": description,
        "dateTime": dateTime?.toIso8601String(),
      };
}
