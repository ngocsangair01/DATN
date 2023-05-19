import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/values/dimens.dart';
import 'package:tourist_app/cores/values/font_asset.dart';
import 'package:tourist_app/cores/values/image_asset.dart';
import 'package:tourist_app/routes/routes.dart';

import '../../../cores/themes/colors.dart';

part 'start_widget.dart';

class StartPage extends BaseGetWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget buildWidgets() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.statusBarColor(),
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: _buildWidget(),
    );
  }
}
