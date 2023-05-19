import 'package:get/get.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/cores/values/const.dart';
import 'package:tourist_app/features/login/controllers/login_ctrl.dart';
import 'package:tourist_app/features/login/models/login_request.dart';
import 'package:tourist_app/routes/routes.dart';

import '../../../cores/utils/widget/base_widget/key_board.dart';
import '../models/login_model.dart';

class LoginCtrlImp extends LoginCtrl {
  @override
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      KeyBoard.hide();
      showLoadingSubmit();
      BaseResponse userResponse = await loginRepository.login(LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ));
      if (userResponse.reasons.isNotEmpty) {
        showSnackBar(userResponse.reasons[0], isSuccess: false);
      }
      if (userResponse.reasons.isEmpty) {
        User user = User.fromJson(userResponse.data);
        HIVE_USER.put('user', user);
        HIVE_APP.put(AppConst.keyToken, user.jwt);
        Get.offAllNamed(AppRoutes.routeHome);
        showSnackBar(userResponse.message.toString(), isSuccess: true);
      }
    }
    hideLoadingSubmit();
  }
}
