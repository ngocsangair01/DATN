import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/key_board.dart';
import 'package:tourist_app/cores/values/font_asset.dart';
import 'package:tourist_app/features/destination/controllers/destination_ctrl.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/models/province_model.dart';
import '../../../cores/themes/box_shadows.dart';
import '../../../cores/themes/colors.dart';
import '../../../cores/utils/widget/base_widget/card_items.dart';
import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/const_widget.dart';
import '../../../cores/utils/widget/utils_button.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/dimens.dart';
import '../../../cores/values/image_asset.dart';
import '../controllers/destination_ctrl_imp.dart';

part 'destination_widget.dart';

class DestinationPage extends BaseGetWidget<DestinationCtrl> {
  const DestinationPage({Key? key}) : super(key: key);

  @override
  DestinationCtrl get controller => Get.put(DestinationCtrlImp());

  @override
  Widget buildWidgets() {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: baseShowLoading(
        () => _buildPage(controller),
      ),
    );
  }
}
