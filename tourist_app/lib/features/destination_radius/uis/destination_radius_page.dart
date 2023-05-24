import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/utils/widget/utils_widget.dart';
import 'package:tourist_app/features/destination_radius/controllers/destination_radius_ctrl.dart';
import 'package:tourist_app/features/map/models/address_response.dart';

import '../../../cores/themes/colors.dart';
import '../../../cores/utils/models/input_text_form_field_model.dart';
import '../../../cores/utils/widget/base_widget/basic_widget.dart';
import '../../../cores/utils/widget/base_widget/card_items.dart';
import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/loading_button.dart';
import '../../../cores/values/dimens.dart';
import '../../../cores/values/font_asset.dart';
import '../../../cores/values/image_asset.dart';
import '../../../routes/routes.dart';
import '../../itinerary/values/itinerary_values.dart';
import '../controllers/destination_radius_ctrl_imp.dart';

part 'destination_radius_widget.dart';

class DestinationRadiusPage extends BaseGetWidget<DestinationRadiusCtrl> {
  const DestinationRadiusPage({Key? key}) : super(key: key);

  @override
  DestinationRadiusCtrl get controller => Get.put(DestinationRadiusCtrlImp());

  @override
  Widget buildWidgets() {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: baseShowLoading(
        () => _buildPage(controller),
      ),
    );
  }
}
