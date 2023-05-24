import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/enums/input_formatter_enum.dart';
import 'package:tourist_app/cores/values/font_asset.dart';
import 'package:tourist_app/features/sign_up/controllers/sign_up_ctrl_imp.dart';
import '../../../cores/enums/enum_type_input.dart';
import '../../../cores/themes/colors.dart';
import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/const_widget.dart';
import '../../../cores/utils/widget/loading_button.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/dimens.dart';
import '../../../cores/values/image_asset.dart';
import '../../../routes/routes.dart';
import '../../map/models/address_response.dart';
import '../controllers/sign_up_ctrl.dart';

part 'sign_up_widget.dart';

class SignUpPage extends BaseGetWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpCtrl get controller => Get.put(SignUpCtrlImp());

  @override
  Widget buildWidgets() {
    return Scaffold(
      body: Center(
        child: _buildWidget(controller),
      ),
    );
  }
}
