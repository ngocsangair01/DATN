import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/features/itinerary/values/itinerary_values.dart';
import 'package:tourist_app/features/map/models/display_itinenary_request.dart';
import 'package:tourist_app/features/map/uis/map_page.dart';
import '../../../cores/themes/box_shadows.dart';
import '../../../cores/themes/colors.dart';
import '../../../cores/utils/models/button_model.dart';
import '../../../cores/utils/models/input_text_form_field_model.dart';
import '../../../cores/utils/widget/base_widget/basic_widget.dart';
import '../../../cores/utils/widget/base_widget/card_items.dart';
import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/const_widget.dart';
import '../../../cores/utils/widget/loading_button.dart';
import '../../../cores/utils/widget/utils_button.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/dimens.dart';
import '../../../cores/values/font_asset.dart';
import '../controllers/itinerary_ctrl_imp.dart';
import '../controllers/itinerary_ctrl.dart';

part 'itinerary_widget.dart';

class ItineraryPage extends BaseGetWidget<ItineraryCtrl> {
  final String? address;
  const ItineraryPage({
    Key? key,
    this.address,
  }) : super(key: key);

  @override
  ItineraryCtrl get controller => Get.put(ItineraryCtrlImp(address));

  @override
  Widget buildWidgets() {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: baseShowLoading(() => _buildPage(controller)),
    );
  }
}
