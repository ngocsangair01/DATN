import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/cores/utils/widget/convert_date_time.dart';
import 'package:tourist_app/features/sign_up/controllers/sign_up_ctrl.dart';
import 'package:tourist_app/features/sign_up/models/sign_up_request.dart';
import 'package:tourist_app/routes/routes.dart';

class SignUpCtrlImp extends SignUpCtrl {
  @override
  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      try {
        showLoadingSubmit();
        SignUpRequest request = SignUpRequest(
          dateOfBirth: MyDateConverter.parseDateTime(birthdayController.text),
          email: emailController.text,
          firstName: firstNameController.text,
          idAddress: idAddress,
          lastName: lastNameController.text,
          password: passwordController.text,
          telephone: telephoneController.text,
        );
        var response = await signUpRepository.signUp(request);
        if (response.restStatus != "SUCCESS") {
          showSnackBar(response.reasons.first, isSuccess: false);
          hideLoadingSubmit();
        } else {
          Get.offAllNamed(AppRoutes.routeLogin);
          showSnackBar(response.message ?? "");
        }
      } finally {
        hideLoadingSubmit();
      }
    }
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
}
