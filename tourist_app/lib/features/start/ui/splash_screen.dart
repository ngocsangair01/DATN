import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';

import '../../../cores/values/dimens.dart';
import '../../../cores/values/font_asset.dart';
import '../../../cores/values/image_asset.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AppController(), permanent: true);
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageAsset.imgBackground,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
