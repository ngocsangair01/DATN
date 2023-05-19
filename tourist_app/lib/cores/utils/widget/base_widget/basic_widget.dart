import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/cores/extensions/validate.dart';
import '../../../values/dimens.dart';
import '../../../values/strings.dart';
import '../../models/input_text_form_field_model.dart';
import '../input_text_form_with_label.dart';
import '../utils_widget.dart';
import 'input_text_form.dart';

class BasicWidget {
  static Widget buildInputWithLabel(
    String label,
    InputTextModel inputTextModel, {
    bool isValidate = false,
    bool showDivider = true,
    EdgeInsetsGeometry? paddingText,
    EdgeInsetsGeometry? contentPadding,
    double? padding,
    TextStyle? labelStyle,
  }) {
    return Column(
      children: [
        BuildInputTextWithLabel(
          textStyle: labelStyle,
          label: label,
          labelRequired: isValidate ? " *" : "",
          padding: padding ?? AppDimen.paddingSmall,
          paddingText: paddingText ??
              const EdgeInsets.only(
                top: AppDimen.paddingSmall,
              ),
          buildInputText: BuildInputText(inputTextModel
            ..contentPadding = contentPadding ?? EdgeInsets.zero
            ..hintText = inputTextModel.hintText
            ..hintTextColor = Colors.grey
            ..hintTextSize = AppDimen.fontSmall()
            ..validator = inputTextModel.validator ??
                (val) {
                  if (isValidate) {
                    if (val!.isStringEmpty) {
                      return label + AppStr.errorEmpty;
                    }
                    return null;
                  }

                  return null;
                }),
        ),
        if (showDivider)
          UtilWidget.buildDivider(
            indent: padding ?? AppDimen.paddingSmall,
            endIndent: padding ?? AppDimen.paddingSmall,
          ),
      ],
    );
  }

  static Widget buildInputWithIcon(
    String label,
    InputTextModel inputTextModel, {
    Widget? icon,
    bool isValidate = false,
    bool showDivider = true,
  }) {
    return BuildInputTextWithLabel(
      label: label,
      labelRequired: isValidate ? " *" : "",
      buildInputText: BuildInputText(inputTextModel
        ..hintTextSize = AppDimen.fontSmall()
        ..hintText = label
        ..border = const UnderlineInputBorder()
        ..suffixIcon = icon
        ..helperStyle = Get.textTheme.subtitle2?.copyWith(
          fontSize: AppDimen.fontMedium(),
        )
        ..validator = inputTextModel.validator ??
            (val) {
              if (isValidate) {
                if (val!.isStringEmpty) {
                  return label + AppStr.errorEmpty;
                }
                return null;
              }

              return null;
            }),
    );
  }
}
