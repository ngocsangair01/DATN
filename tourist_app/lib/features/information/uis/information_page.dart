import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/page.dart';
import 'package:tourist_app/features/information/controllers/information_ctrl.dart';
import 'package:tourist_app/features/information/controllers/information_ctrl_imp.dart';

import '../../../cores/enums/enum_type_input.dart';
import '../../../cores/enums/input_formatter_enum.dart';
import '../../../cores/themes/colors.dart';
import '../../../cores/utils/widget/const_widget.dart';
import '../../../cores/utils/widget/loading_button.dart';
import '../../../cores/utils/widget/utils_button.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/dimens.dart';
import '../../../cores/values/font_asset.dart';
import '../../../cores/values/image_asset.dart';
import '../../../routes/routes.dart';
import '../../map/models/address_response.dart';

part 'information_widget.dart';

class InformationPage extends BaseGetWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  InformationCtrl get controller => Get.put(InformationCtrlImp());

  @override
  Widget buildWidgets() {
    return Scaffold(
      body: Center(
        child: _buildWidget(controller),
      ),
    );
  }
}
