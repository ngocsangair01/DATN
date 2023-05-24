import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';
import 'package:tourist_app/features/information/repositories/information_repository.dart';

abstract class InformationCtrl extends BaseGetXController {
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
  late InformationRepository informationRepository;
  InformationCtrl() {
    informationRepository = InformationRepository(this);
  }
  Future<void> changeInformation();
  void showDatePickerDisplay();
  Future<void> getInformationDetail();
}
