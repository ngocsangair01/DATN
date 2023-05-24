import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/cores/enums/enum_type_input.dart';
import 'package:tourist_app/features/login/controllers/login_ctrl.dart';
import 'package:tourist_app/features/login/controllers/login_ctrl_imp.dart';

import '../../../cores/themes/colors.dart';
import '../../../cores/utils/models/button_model.dart';
import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/const_widget.dart';
import '../../../cores/utils/widget/loading_button.dart';
import '../../../cores/utils/widget/utils_button.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/dimens.dart';
import '../../../cores/values/font_asset.dart';
import '../../../cores/values/image_asset.dart';
part 'login_widget.dart';

class LoginPage extends BaseGetWidget<LoginCtrl> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginCtrl get controller => Get.put(LoginCtrlImp());

  @override
  Widget buildWidgets() {
    Get.put(AppController(), permanent: true);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.statusBarColor(),
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: _buildWidget(controller),
    );
  }
}
