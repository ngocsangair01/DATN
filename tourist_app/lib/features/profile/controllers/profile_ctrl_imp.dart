import 'package:get/get.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/features/profile/controllers/profile_ctrl.dart';
import 'package:tourist_app/routes/routes.dart';

import '../../../cores/values/const.dart';

class ProfileCtrlImp extends ProfileCtrl {
  @override
  Future<void> logout() async {
    await HIVE_APP.delete(AppConst.keyToken);
    await HIVE_USER.delete('user');
    await HIVE_APP.delete('user_name');
    await HIVE_APP.delete('password').whenComplete(
      () {
        Get.offAllNamed(AppRoutes.routeStart);
        showSnackBar(
          "Logged out",
          isSuccess: true,
        );
      },
    );
  }
}
