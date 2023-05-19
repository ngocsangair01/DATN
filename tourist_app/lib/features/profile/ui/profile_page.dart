import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/page.dart';
import 'package:tourist_app/cores/values/dimens.dart';
import 'package:tourist_app/cores/values/font_asset.dart';
import 'package:tourist_app/features/profile/controllers/profile_ctrl.dart';
import 'package:tourist_app/routes/routes.dart';

import '../../../cores/values/image_asset.dart';

part 'profile_widget.dart';

class ProfilePage extends BaseGetWidget<ProfileCtrl> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    return _buildPage();
  }
}
