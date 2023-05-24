import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/cores/utils/widget/utils_widget.dart';

import '../../../base/controllers/src_controller.dart';
import '../../values/dimens.dart';

class LoadingButton<T extends BaseGetXController> extends StatelessWidget {
  const LoadingButton(this.controller,
      {Key? key,
      required this.title,
      required this.func,
      this.width,
      this.icon})
      : super(key: key);
  final T controller;
  final String title;
  final Function() func;
  final double? width;
  final IconData? icon;
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
        icon: !controller.isShowLoadingSubmit.value ? icon : null,
      ).paddingOnly(bottom: AppDimen.paddingVerySmall),
    );
  }
}

class LoadingButton2<T extends BaseGetXController> extends StatelessWidget {
  const LoadingButton2(this.controller,
      {Key? key,
      required this.title,
      required this.func,
      this.width,
      this.icon})
      : super(key: key);
  final T controller;
  final String title;
  final Function() func;
  final double? width;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => UtilWidget.buildButton(
        title,
        func,
        isLoading: controller.isShowLoadingSubmit2.value,
        backgroundColor: AppColors.baseColorGreen,
        radius: 50,
        width: width ?? Get.width * AppDimen.resolutionWidgetButton,
        icon: !controller.isShowLoadingSubmit2.value ? icon : null,
        paddingRight: 0,
      ).paddingOnly(bottom: AppDimen.paddingVerySmall),
    );
  }
}
