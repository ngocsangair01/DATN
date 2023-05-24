import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/cores/utils/widget/show_popup.dart';
import 'package:tourist_app/features/weather/controllers/weather_ctrl.dart';
import 'package:tourist_app/features/weather/models/lat_lng_request.dart';
import 'package:tourist_app/features/weather/models/weather_response_list_model.dart';
import 'package:tourist_app/features/weather/models/weather_response_model.dart';
import 'package:tourist_app/features/weather/utils/merge_weather_object.dart';

import '../../../cores/values/image_asset.dart';

class WeatherCtrlImp extends WeatherCtrl {
  @override
  List<CurrentWeather> get weatherNow =>
      weatherResponseModel?.weatherInformationList
          .where((element) => _focusWeatherIn24hour(element.dateTime))
          .toList() ??
      [];

  bool _focusWeatherIn24hour(DateTime? dateTime) =>
      (dateTime?.isAfter(DateTime.now()) ?? false) &&
      ((dateTime?.difference(DateTime.now()).inHours ?? 0) < 24);

  @override
  List<CurrentWeather> get weatherOfDays =>
      weatherResponseModel!.weatherInformationList.findMax();

  @override
  Future<void> onInit() async {
    try {
      showLoading();
      getDateTime();
      await requestLocationPermission();
      await getWeatherLatLng();
      await getInformationWeatherForManyProvince(isRefresh: true);
      setTextColorWithBackgroundColor();
    } finally {
      hideLoading();
    }

    locationStream().listen(
      (event) {
        if (event != locationPermissionGranted.value) {
          locationPermissionGranted.value = event;
          if (locationPermissionGranted.value) {
            getLocationInfo();
          }
        }
      },
    );
    super.onInit();
  }

  @override
  Future<void> requestLocationPermission() async {
    final status = await Geolocator.requestPermission();
    if (status == LocationPermission.always ||
        status == LocationPermission.whileInUse) {
      locationPermissionGranted.value = true;
      await getLocationInfo();
    } else {
      locationPermissionGranted.value = false;
      showLocationExplanation();
    }
  }

  @override
  Future<void> getLocationInfo() async {
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        longitude.value = value.longitude;
        latitude.value = value.latitude;
      });
    } on PlatformException catch (e) {
      showSnackBar('Error: ${e.message}');
    }
  }

  @override
  void showLocationExplanation() {
    ShowPopup.showDialogConfirm(
      "We need location access to be able to give you the latest on your current weather",
      actionTitle: 'Accept',
      confirm: () async {
        await Geolocator.openAppSettings();
      },
    );
  }

  @override
  Future<void> getWeatherLatLng() async {
    var res = await weatherRepository.getListWeatherForecastLatLng(
      LatLngRequest(
        lat: latitude.value,
        lon: longitude.value,
      ),
    );
    if (res.data != null) {
      weatherResponseModel = res.data;
      nameProvince.value = weatherResponseModel?.nameProvince ?? "";
      currentWeather.value.temp = weatherResponseModel?.currentWeather?.temp;
      currentWeather.value.feelsLike =
          weatherResponseModel?.currentWeather?.feelsLike;
      currentWeather.value.tempMin =
          weatherResponseModel?.currentWeather?.tempMin;
      currentWeather.value.tempMax =
          weatherResponseModel?.currentWeather?.tempMax;
      currentWeather.value.humidity =
          weatherResponseModel?.currentWeather?.humidity;
      currentWeather.value.main = weatherResponseModel?.currentWeather?.main;
      currentWeather.value.description =
          weatherResponseModel?.currentWeather?.description;
      currentWeather.value.dateTime =
          weatherResponseModel?.currentWeather?.dateTime;
      listWeatherForecast.value =
          weatherResponseModel?.weatherInformationList ?? [];
    }
  }

  @override
  void setTextColorWithBackgroundColor() {
    getBackground();
    if (background.value == ImageAsset.imgCloudyWeather ||
        background.value == ImageAsset.imgSunnyWeather) {
      textColor = Colors.black;
      colorBackground.value = Colors.white.withOpacity(0.7);
    } else {
      textColor = Colors.white;
      colorBackground.value = Colors.black.withOpacity(0.7);
    }
  }

  @override
  void getBackground() {
    if (currentWeather.value.main == "Thunderstorm") {
      background.value = ImageAsset.imgThunderstormWeather;
    }
    if (currentWeather.value.main == "Drizzle") {
      background.value = ImageAsset.imgDrizzleWeather;
    }
    if (currentWeather.value.main == "Rain") {
      background.value = ImageAsset.imgRainyWeather;
    }
    if (currentWeather.value.main == "Snow") {
      background.value = ImageAsset.imgSnowyWeather;
    }
    if (currentWeather.value.main == "Clear") {
      background.value = ImageAsset.imgClearWeather;
    }
    if (currentWeather.value.main == "Clouds") {
      background.value = ImageAsset.imgCloudyWeather;
    }
    if (currentWeather.value.main == "Sunny") {
      background.value = ImageAsset.imgThunderstormWeather;
    }
  }

  @override
  Future<void> getInformationWeatherForManyProvince(
      {bool isRefresh = false}) async {
    if (isRefresh) {
      weatherRequestListModel
        ..page = 0
        ..size = 20;
      pageNumber = 0;
    } else {
      weatherRequestListModel.page = pageNumber;
    }
    BaseResponseList<WeatherResponseListModel> res = await weatherRepository
        .getListCurrentWeather(weatherRequestListModel)
        .whenComplete(() => hideLoading());
    if (isRefresh) {
      refreshController.refreshCompleted();
    } else {
      refreshController.loadComplete();
    }
    if (res.restStatus == "SUCCESS") {
      if (isRefresh) {
        rxList.clear();
      }
      rxList.addAll(res.data);
      getIconTrailing();
    } else {
      showSnackBar(
        res.reasons[0],
        isSuccess: false,
      );
    }
  }

  void getIconTrailing() {
    for (int i = 0; i < rxList.length; i++) {
      if (rxList[i].main == "Thunderstorm") {
        rxList[i].icon = SvgPicture.asset(
          ImageAsset.iconThunderstorm,
          color: Colors.blue.shade100,
        );
      }
      if (rxList[i].main == "Drizzle") {
        rxList[i].icon = SvgPicture.asset(
          ImageAsset.iconRain,
          color: Colors.grey.shade400,
        );
      }
      if (rxList[i].main == "Rain") {
        rxList[i].icon = SvgPicture.asset(
          ImageAsset.iconRain,
          color: Colors.grey.shade400,
        );
      }
      if (rxList[i].main == "Snow") {
        rxList[i].icon = SvgPicture.asset(
          ImageAsset.iconSnow,
          color: Colors.white,
        );
      }
      if (rxList[i].main == "Clear") {
        rxList[i].icon = SvgPicture.asset(
          ImageAsset.iconSun,
          color: Colors.yellow.shade200,
        );
      }
      if (rxList[i].main == "Clouds") {
        rxList[i].icon = SvgPicture.asset(
          ImageAsset.iconCloud,
          color: Colors.cyan.shade200,
        );
      }
      if (rxList[i].main == "Sunny") {
        rxList[i].icon = SvgPicture.asset(
          ImageAsset.iconSun,
          color: Colors.white,
        );
      }
    }
  }

  @override
  Future<void> getInformationWeatherForOneProvince(
      {bool isRefresh = false}) async {}

  @override
  Future<void> functionSearch() async {
    weatherRequestListModel.keyword = textSearchProvinceController.text;
    pageNumber = 0;
    await getInformationWeatherForManyProvince(isRefresh: true);
  }

  @override
  Future<void> onLoadMore() async {
    pageNumber++;
    await getInformationWeatherForManyProvince();
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    pageNumber = 0;
    rxList.clear();
    await getInformationWeatherForManyProvince(isRefresh: true);
    refreshController.refreshCompleted();
  }

  ///==============================Stream============================
  Future<bool> locationPermissionAccess() async => [
        LocationPermission.always,
        LocationPermission.whileInUse
      ].contains(await Geolocator.checkPermission());

  Future<bool> serviceIsEnable() async =>
      await Geolocator.isLocationServiceEnabled();

  Stream<bool> locationStream() async* {
    while (true) {
      if (locationPermissionGranted.value) {
        yield true;
      } else {
        if (await serviceIsEnable()) {
          if (await locationPermissionAccess()) {
            yield true;
          } else {
            yield false;
          }
        } else {
          yield false;
        }
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Future<void> getWeatherById({int? id}) async {
    var res = await weatherRepository.getListWeatherForecast(id ?? 1);
    if (res.data != null) {
      weatherResponseModel = res.data;
      nameProvince.value = weatherResponseModel?.nameProvince ?? "";
      currentWeather.value.temp = weatherResponseModel?.currentWeather?.temp;
      currentWeather.value.feelsLike =
          weatherResponseModel?.currentWeather?.feelsLike;
      currentWeather.value.tempMin =
          weatherResponseModel?.currentWeather?.tempMin;
      currentWeather.value.tempMax =
          weatherResponseModel?.currentWeather?.tempMax;
      currentWeather.value.humidity =
          weatherResponseModel?.currentWeather?.humidity;
      currentWeather.value.main = weatherResponseModel?.currentWeather?.main;
      currentWeather.value.description =
          weatherResponseModel?.currentWeather?.description;
      currentWeather.value.dateTime =
          weatherResponseModel?.currentWeather?.dateTime;
      listWeatherForecast.value =
          weatherResponseModel?.weatherInformationList ?? [];
      setTextColorWithBackgroundColor();
    }
  }

  @override
  void getDateTime() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        dateTimeFormat.value =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      },
    );
  }
}
