import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/values/dimens.dart';
import 'package:tourist_app/features/destination_management/controllers/destination_management_ctrl.dart';
import 'package:tourist_app/features/destination_management/controllers/destination_management_ctrl_imp.dart';
import '../../../cores/themes/colors.dart';
import '../../../cores/utils/widget/base_widget/key_board.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/image_asset.dart';
import '../../destination/models/destination_model.dart';

part 'destination_management_widget.dart';

class DestinationManagementPage extends BaseGetWidget {
  const DestinationManagementPage({Key? key}) : super(key: key);

  @override
  DestinationManagementCtrl get controller =>
      Get.put(DestinationManagementCtrlImp());

  @override
  Widget buildWidgets() {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: baseShowLoading(
        () => _buildPageDestinationManager(controller),
      ),
    );
  }
}
