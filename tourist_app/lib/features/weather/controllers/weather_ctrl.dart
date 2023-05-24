import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';
import 'package:tourist_app/features/weather/models/base_request_list_model.dart';
import 'package:tourist_app/features/weather/models/weather_response_list_model.dart';
import 'package:tourist_app/features/weather/models/weather_response_model.dart';
import 'package:tourist_app/features/weather/repositories/weather_repository.dart';

abstract class WeatherCtrl
    extends BasePageSearchController<WeatherResponseListModel> {
  Color? textColor;
  RxString background = "".obs;
  int pageNumber = 0;
  RxBool locationPermissionGranted = true.obs;
  RxBool locationServiceEnable = false.obs;
  RxBool locationEnable = false.obs;
  Rx<DateTime> timeSelect = DateTime.now().obs;
  RxBool isClear = false.obs;
  TextEditingController textSearchProvinceController = TextEditingController();

  ///Toạ độ Hà Nội
  RxDouble longitude = 105.8341598.obs;
  RxDouble latitude = 21.0277644.obs;
  //===
  ///Thông tin hiển thị màn hình
  ///CurrentWeather
  RxString nameProvince = "".obs;
  RxString dateTimeFormat = "".obs;
  Rx<CurrentWeather> currentWeather = CurrentWeather().obs;
  RxList<CurrentWeather> listWeatherForecast = RxList([]);

  List<CurrentWeather> get weatherNow;

  List<CurrentWeather> get weatherOfDays;

  Rx<Color> colorBackground = Colors.white.obs;
  late final WeatherRepository weatherRepository;
  WeatherResponseModel? weatherResponseModel;
  late BaseRequestListModel weatherRequestListModel;
  WeatherCtrl() {
    weatherRepository = WeatherRepository(this);
    weatherRequestListModel = BaseRequestListModel(
      keyword: "",
      page: 0,
      size: 20,
    );
  }
  void setTextColorWithBackgroundColor();
  void getBackground();
  Future<void> getInformationWeatherForOneProvince({
    bool isRefresh = false,
  });
  Future<void> getInformationWeatherForManyProvince({
    bool isRefresh = false,
  });
  void showLocationExplanation();
  Future<void> requestLocationPermission();
  Future<void> getLocationInfo();
  Future<void> getWeatherLatLng();
  Future<void> getWeatherById({int? id});
  void getDateTime();
}
