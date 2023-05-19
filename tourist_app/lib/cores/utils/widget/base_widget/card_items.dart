import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../values/dimens.dart';
import '../utils_widget.dart';

class CardUtils {
  static Widget buildCardCustomRadiusBorder({
    double? radiusTopRight,
    double? radiusTopLeft,
    double? radiusBottomRight,
    double? radiusBottomLeft,
    required Widget child,
    double? radiusAll,
    double spreadRadius = 2.5,
    double blurRadius = 10,
    List<BoxShadow>? boxShadows,
    Color? backgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        //Here goes the same radius, u can put into a var or function
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radiusAll ?? radiusBottomRight ?? 0),
          bottomLeft: Radius.circular(radiusAll ?? radiusBottomLeft ?? 0),
          topLeft: Radius.circular(radiusAll ?? radiusTopLeft ?? 0),
          topRight: Radius.circular(radiusAll ?? radiusTopRight ?? 0),
        ),
        boxShadow: boxShadows,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radiusAll ?? radiusBottomRight ?? 0),
          bottomLeft: Radius.circular(radiusAll ?? radiusBottomLeft ?? 0),
          topLeft: Radius.circular(radiusAll ?? radiusTopLeft ?? 0),
          topRight: Radius.circular(radiusAll ?? radiusTopRight ?? 0),
        ),
        child: child,
      ),
    );
  }

  static Widget buildContentInCard({
    required String url,
    required Widget cardInfo,
    double? heightImage,
    double? widthImage,
    double? radius,
  }) {
    return Column(
      children: [
        Expanded(
          child: UtilWidget.buildImageWidget(url,
              heightImage: heightImage,
              widthImage: widthImage ?? double.infinity,
              radius: radius),
        ),
        cardInfo.paddingSymmetric(
            horizontal: AppDimen.paddingSmall, vertical: AppDimen.paddingSmall)
      ],
    );
  }
}
