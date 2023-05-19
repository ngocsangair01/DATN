import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/cores/values/font_asset.dart';
import 'package:tourist_app/features/destination_detail/controllers/destination_detail_ctrl.dart';
import 'package:tourist_app/features/destination_detail/controllers/destination_detail_ctrl_imp.dart';
import 'package:tourist_app/features/itinerary/ui/itinerary_page.dart';

import '../../../cores/themes/box_shadows.dart';
import '../../../cores/themes/colors.dart';
import '../../../cores/utils/models/button_model.dart';
import '../../../cores/utils/widget/base_widget/card_items.dart';
import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/const_widget.dart';
import '../../../cores/utils/widget/utils_button.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/dimens.dart';
import '../../../cores/values/image_asset.dart';
import '../../../routes/routes.dart';

part 'destination_detail_widget.dart';

class DestinationDetailPage extends BaseGetWidget {
  const DestinationDetailPage({Key? key}) : super(key: key);

  @override
  DestinationDetailCtrl get controller => Get.put(DestinationDetailCtrlImp());

  @override
  Widget buildWidgets() {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: baseShowLoading(
        () => _buildPageDestinationDetail(controller),
      ),
    );
  }
}
