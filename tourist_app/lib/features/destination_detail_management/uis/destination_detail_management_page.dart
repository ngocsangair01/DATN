import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/cores/utils/models/input_text_form_field_model.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/basic_widget.dart';
import 'package:tourist_app/cores/utils/widget/const_widget.dart';
import 'package:tourist_app/cores/utils/widget/utils_button.dart';
import 'package:tourist_app/cores/utils/widget/utils_widget.dart';
import 'package:tourist_app/cores/values/dimens.dart';
import 'package:tourist_app/features/destination/ui/destination_page.dart';
import 'package:tourist_app/features/destination_detail_management/controllers/destination_detail_management_ctrl.dart';
import 'package:tourist_app/features/destination_detail_management/controllers/destination_detail_management_ctrl_imp.dart';
import 'package:tourist_app/routes/routes.dart';

import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/loading_button.dart';
import '../../../cores/values/font_asset.dart';
import '../../../cores/values/image_asset.dart';
import '../values/destination_detail_management_values.dart';

part 'destination_detail_management_widget.dart';

class DestinationDetailManagementPage extends BaseGetWidget {
  const DestinationDetailManagementPage({Key? key}) : super(key: key);

  @override
  DestinationDetailManagementCtrl get controller =>
      Get.put(DestinationDetailManagementCtrlImp());

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
