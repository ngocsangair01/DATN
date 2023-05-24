import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/features/information/controllers/information_ctrl.dart';
import 'package:tourist_app/features/information/models/user_request.dart';
import 'package:tourist_app/features/information/models/user_response.dart';

import '../../../cores/themes/colors.dart';

class InformationCtrlImp extends InformationCtrl {
  @override
  Future<void> onInit() async {
    await getInformationDetail();
    super.onInit();
  }

  @override
  void showDatePickerDisplay() {
    showDatePicker(
      context: Get.overlayContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.baseColorGreen,
              onPrimary: Colors.white, // Màu chữ trên DatePicker
            ),
            dialogBackgroundColor: Colors.white, // Màu nền của DatePicker
          ),
          child: child!,
        );
      },
    ).then((selectedDate) {
      if (selectedDate != null) {
        selectedDateOnDialog.value = selectedDate;
      }
    }).whenComplete(() {
      final formatter = DateFormat('yyyy-MM-dd');
      birthdayController.text = formatter.format(selectedDateOnDialog.value);
    });
  }

  @override
  Future<void> changeInformation() async {
    if (formKey.currentState!.validate()) {
      try {
        showLoadingSubmit();
        UserRequest userRequest = UserRequest(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          dateOfBirth: DateTime.tryParse(birthdayController.text),
          email: emailController.text,
          password: passwordController.text,
          telephone: telephoneController.text,
          idAddress: idAddress,
        );
        BaseResponse<UserResponse> response = await informationRepository
            .saveUser(userRequest, HIVE_USER.get('user')?.userId ?? 0);
        if (response.restStatus == "SUCCESS") {
          Get.back();
          showSnackBar("Change information successfully", isSuccess: true);
        }
      } finally {
        hideLoadingSubmit();
      }
    }
  }

  @override
  Future<void> getInformationDetail() async {
    BaseResponse<UserResponse> result =
        await informationRepository.getDetailUserById(
      HIVE_USER.get('user')?.userId ?? 0,
    );
    if (result.restStatus == "SUCCESS") {
      if (result.data != null) {
        UserResponse userResponse = result.data!;
        firstNameController.text = userResponse.firstName ?? "";
        lastNameController.text = userResponse.lastName ?? "";
        emailController.text = userResponse.email ?? "";
        passwordController.text = userResponse.password ?? "";
        telephoneController.text = userResponse.telephone ?? "";
        birthdayController.text = DateFormat('yyyy-MM-dd')
            .format(userResponse.dateOfBirth ?? DateTime.now());
        addressController.text = userResponse.address?.detailAddress ?? "";
        idAddress = userResponse.address?.id ?? 0;
      }
    }
  }
}
