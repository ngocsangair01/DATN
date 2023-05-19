import 'dart:ui';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/cores/values/image_asset.dart';
import 'package:tourist_app/features/home/controllers/home_ctrl.dart';
import 'package:tourist_app/features/home/controllers/home_ctrl_imp.dart';

part 'home_widget.dart';

class HomePage extends BaseGetWidget<HomeCtrl> {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeCtrl get controller => Get.put(HomeCtrlImp());

  @override
  Widget buildWidgets() {
    return Scaffold(
      body: _buildBody(controller),
      extendBody: true,
      bottomNavigationBar:
          (controller.bottomBarPages.length <= controller.maxCount)
              ? Stack(
                  children: [
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 5,
                          sigmaY: 5,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          width: Get.width,
                          height: 99,
                        ),
                      ),
                    ),
                    _buildNotchBottomBar(controller),
                  ],
                )
              : null,
    );
  }
}
