import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/features/sign_up/repositories/sign_up_repository.dart';

abstract class SignUpCtrl extends BaseGetXController {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString dateOfBirth = "".obs;
  int? idAddress;
  Rx<DateTime> selectedDateOnDialog = DateTime.now().obs;
  late SignUpRepository signUpRepository;
  SignUpCtrl() {
    signUpRepository = SignUpRepository(this);
  }
  Future<void> signUp();
  void showDatePickerDisplay();
}
