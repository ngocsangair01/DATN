import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tourist_app/features/login/models/login_model.dart';

import '../../base/controllers/src_controller.dart';
import '../../base/repositories/base_request.dart';
import '../../hive/register_adapters.dart';
import '../../routes/routes.dart';
import '../values/const.dart';

late Box HIVE_APP;
late Box<User> HIVE_USER;
//HIVE Data

Connectivity connectivity = Connectivity();
final controllerConnect = StreamController.broadcast();
late StreamSubscription<ConnectivityResult> connectivitySubscription;

class AppController extends GetxController {
  final RxBool isShowSupportCus = true.obs;

  /// check xem có sử dụng vân tay hoặc faceid hay không
  RxBool isFaceID = false.obs;

  RxBool isOffline = false.obs;
  RxBool showOnline = false.obs;
  RxInt numberBillOffline = 0.obs;
  RxBool syncSuccess = false.obs;
  @override
  void onInit() {
    initHive().then((value) async {
      await dotenv.load(fileName: ".env");
      final apiKey = dotenv.env['API_KEY'];
      HIVE_APP.put('apiGoogle', apiKey);
      Get.put(BaseRequest(), permanent: true);
      print(apiKey);
      Get.put(BaseGetXController(), permanent: true);
      try {
        Get.offNamed(AppRoutes.routeLogin);
      } catch (e) {
        Get.offNamed(AppRoutes.routeLogin);
      }
    });

    super.onInit();
  }

  @override
  void dispose() {
    controllerConnect.close();
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initHive() async {
    WidgetsFlutterBinding.ensureInitialized();

    registerAdapters();
    await openBox();
  }

  bool _checkSessionLogin() {
    return HIVE_APP.get(AppConst.keyToken) == null;
  }
}
