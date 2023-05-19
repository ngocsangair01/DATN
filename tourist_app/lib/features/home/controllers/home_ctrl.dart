import 'package:flutter/material.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/cores/values/const.dart';
import '../../destination/ui/destination_page.dart';
import '../../favorite/ui/favorite_page.dart';
import '../../profile/ui/profile_page.dart';
import '../../weather/ui/weather_page.dart';

abstract class HomeCtrl extends BaseGetXController {
  final pageController = PageController(initialPage: 0);
  late final int keyUser;
  late final int keyToken;
  int maxCount = 4;
  final List<Widget> bottomBarPages = [
    const DestinationPage(),
    const FavoritePage(),
    const WeatherPage(),
    const ProfilePage(),
  ];
}
