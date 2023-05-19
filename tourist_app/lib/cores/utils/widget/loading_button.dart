import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/cores/utils/widget/utils_widget.dart';

import '../../../base/controllers/src_controller.dart';
import '../../values/dimens.dart';

class LoadingButton<T extends BaseGetXController> extends StatelessWidget {
  const LoadingButton(this.controller,
      {Key? key, required this.title, required this.func, this.width})
      : super(key: key);
  final T controller;
  final String title;
  final Function() func;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => UtilWidget.buildButton(
        title,
        func,
        isLoading: controller.isShowLoadingSubmit.value,
        backgroundColor: AppColors.baseColorGreen,
        radius: 50,
        width: width ?? Get.width * AppDimen.resolutionWidgetButton,
      ).paddingOnly(bottom: AppDimen.paddingVerySmall),
    );
  }
}
