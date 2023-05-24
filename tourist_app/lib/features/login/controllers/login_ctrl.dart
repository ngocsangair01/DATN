import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';

import '../../../cores/apps/app_controller.dart';
import '../repositories/login_repository.dart';

abstract class LoginCtrl extends BaseGetXController {
  TextEditingController emailController =
      TextEditingController(text: HIVE_APP.get('user_name'));
  TextEditingController passwordController = TextEditingController();
  TextEditingController searchCtr = TextEditingController();
  TextEditingController adult = TextEditingController();
  TextEditingController kids = TextEditingController();
  AppController appController = Get.find<AppController>();

  late final LoginRepository loginRepository;
  final formKey = GlobalKey<FormState>();

  LoginCtrl() {
    loginRepository = LoginRepository(this);
  }
  void login();
  Future<void> loginWithFingerPrint();
}
