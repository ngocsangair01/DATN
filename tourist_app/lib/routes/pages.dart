import 'package:get/get.dart';
import 'package:tourist_app/features/destination/ui/destination_page.dart';
import 'package:tourist_app/features/destination_detail/ui/destination_detail_page.dart';
import 'package:tourist_app/features/destination_detail_management/uis/destination_detail_management_page.dart';
import 'package:tourist_app/features/destination_management/uis/destination_management_page.dart';
import 'package:tourist_app/features/favorite/ui/favorite_page.dart';
import 'package:tourist_app/features/home/ui/home_page.dart';
import 'package:tourist_app/features/login/ui/login_page.dart';
import 'package:tourist_app/features/map/uis/map_page.dart';
import 'package:tourist_app/features/profile/ui/profile_page.dart';
import 'package:tourist_app/features/sign_up/ui/sign_up_page.dart';
import 'package:tourist_app/features/start/ui/start_page.dart';
import 'package:tourist_app/features/weather/ui/weather_page.dart';
import 'package:tourist_app/routes/routes.dart';

import '../features/destination_radius/uis/destination_radius_page.dart';
import '../features/information/uis/information_page.dart';
import '../features/itinerary/ui/itinerary_page.dart';
import '../features/start/ui/splash_screen.dart';

class RoutePage {
  static var routes = [
    GetPage(
      name: AppRoutes.initialRoute,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.routeStart,
      page: () => const StartPage(),
    ),
    GetPage(
      name: AppRoutes.routeSignUp,
      page: () => const SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.routeInformation,
      page: () => const InformationPage(),
    ),
    GetPage(
      name: AppRoutes.routeFavorite,
      page: () => const FavoritePage(),
    ),
    GetPage(
      name: AppRoutes.routeLogin,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.routeProfile,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: AppRoutes.routeDestination,
      page: () => const DestinationPage(),
    ),
    GetPage(
      name: AppRoutes.routeDestinationDetail,
      page: () => const DestinationDetailPage(),
    ),
    GetPage(
      name: AppRoutes.routeDestinationManagement,
      page: () => const DestinationManagementPage(),
    ),
    GetPage(
      name: AppRoutes.routeDestinationDetailManagement,
      page: () => const DestinationDetailManagementPage(),
    ),
    GetPage(
      name: AppRoutes.routeHome,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.routeWeather,
      page: () => const WeatherPage(),
    ),
    GetPage(
      name: AppRoutes.routeMapPage,
      page: () => const MapPage(),
    ),
    GetPage(
      name: AppRoutes.routeItinerary,
      page: () => const ItineraryPage(),
    ),
    GetPage(
      name: AppRoutes.routeDestinationRadius,
      page: () => const DestinationRadiusPage(),
    ),
  ];
}
