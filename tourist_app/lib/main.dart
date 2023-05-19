import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tourist_app/routes/pages.dart';
import 'package:tourist_app/routes/routes.dart';

import 'base/controllers/src_controller.dart';
import 'base/repositories/base_request.dart';
import 'cores/themes/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(BaseRequest(), permanent: true);
  Get.put(BaseGetXController(), permanent: true);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.statusBarColor(),
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.routeLogin,
      getPages: RoutePage.routes,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child ?? Container(),
        );
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(color: Colors.white),
        chipTheme: ChipThemeData(
          selectedColor: AppColors.backGroundColorButtonDefault,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
