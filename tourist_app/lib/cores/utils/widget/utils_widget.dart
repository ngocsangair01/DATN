import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tourist_app/cores/extensions/validate.dart';
import '../../../base/controllers/src_controller.dart';
import '../../enums/enum_type_input.dart';
import '../../enums/input_formatter_enum.dart';
import '../../themes/colors.dart';
import '../../values/dimens.dart';
import '../../values/strings.dart';
import '../models/input_text_form_field_model.dart';
import 'base_widget/card_items.dart';
import 'base_widget/debouncer.dart';
import 'base_widget/input_text_form.dart';
import 'const_widget.dart';
import 'dropdown_border.dart';
import 'input_text_form_with_label.dart';
import 'utils_button.dart';

class UtilWidget {
  static DateTime? _dateTime;
  static int _oldFunc = 0;

  static Widget buildLogo(String imgLogo, double height) {
    return SizedBox(
      height: height,
      child: Image.asset(imgLogo),
    );
  }

  static const Widget sizedBox10 = SizedBox(height: 10);
  static const Widget sizedBox10W = SizedBox(width: 10);

  static Widget buildSmartRefresher({
    required RefreshController refreshController,
    required Widget child,
    ScrollController? scrollController,
    Function()? onRefresh,
    Function()? onLoadMore,
    bool enablePullUp = false,
    Widget? customLoadingFooter,
  }) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(Get.context!).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: enablePullUp,
        scrollController: scrollController,
        header: const MaterialClassicHeader(),
        controller: refreshController,
        onRefresh: onRefresh,
        onLoading: onLoadMore,
        footer:
            buildSmartRefresherCustomFooter(loadingWidget: customLoadingFooter),
        child: child,
      ),
    );
  }

  static Widget buildSmartRefresherCustomFooter({Widget? loadingWidget}) {
    return CustomFooter(
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return loadingWidget ?? const CupertinoActivityIndicator();
        } else {
          return const Opacity(
            opacity: 0.0,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }

  static Widget buildText(
    String text, {
    FontWeight? fontWeight,
    TextAlign? textAlign,
    Color? textColor,
    int? maxline,
    double? foniSize,
  }) {
    return AutoSizeText(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: Get.textTheme.bodyText2!.copyWith(
        color: textColor ?? AppColors.textColor(),
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
        fontSize: foniSize ?? AppDimen.fontSmall(),
      ),
      maxLines: maxline ?? 1,
    );
  }

  static Widget buildTextInput({
    var height,
    Color? textColor,
    String? hintText,
    Color? hintColor,
    Color? fillColor,
    TextEditingController? controller,
    Function(String)? onChanged,
    Function()? onTap,
    Widget? prefixIcon,
    Widget? suffixIcon,
    FocusNode? focusNode,
    Color? borderColor,
    bool? autofocus,
    BorderRadius? borderRadius,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        focusNode: focusNode,
        autofocus: autofocus ?? true,
        style: TextStyle(
          color: textColor ?? Colors.black,
        ),
        decoration: InputDecoration(
            hoverColor: Colors.white,
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            filled: true,
            suffixIcon: suffixIcon,
            hintText: hintText ?? "",
            hintStyle: TextStyle(
              color: hintColor ?? Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius: borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(5),
                  ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? Colors.grey),
              borderRadius: borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(5),
                  ),
            ),
            contentPadding: const EdgeInsets.all(10)),
        onChanged: onChanged,
        onTap: onTap,
        controller: controller,
      ),
    );
  }

  static Widget buildSearch({
    required TextEditingController textEditingController,
    String hintSearch = AppStr.hintSearch,
    required Function function,
    required RxBool isClear,
    Color? hintColor,
    Color? borderColor,
    bool? autofocus,
    Color? backgroundColor,
    bool isOnline = true,
    Color? textColor,
    BorderRadius? borderRadius,
    double? height,
  }) {
    return UtilWidget.buildTextInput(
      height: height ?? 40.0,
      controller: textEditingController,
      hintText: hintSearch,
      textColor: textColor,
      hintColor: hintColor ?? AppColors.hintTextColor(),
      borderColor: borderColor ?? AppColors.textColorWhite,
      autofocus: autofocus,
      fillColor: backgroundColor ?? AppColors.textColorWhite,
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(25)),
      onChanged: (v) {
        onTextChange(
          () {
            function();
            isClear.value = textEditingController.text.isNotEmpty;
          },
          isOnline: isOnline,
        );
      },
      prefixIcon: const Icon(
        Icons.search,
        color: AppColors.lightPrimaryColor,
        size: 20,
      ),
      suffixIcon: Obx(() => Visibility(
            visible: isClear.value,
            child: IconButton(
              onPressed: () {
                textEditingController.clear();
                isClear.value = false;
                function();
              },
              icon: Icon(
                Icons.clear,
                color: AppColors.hintTextColor(),
              ),
            ).paddingOnly(bottom: AppDimen.paddingSmall),
          )),
    ).paddingSymmetric(vertical: AppDimen.paddingSmall);
  }

  static Widget buildSlideTransition<T extends BaseGetXController>({
    required Widget Function(int, T) child,
    required int itemsCount,
    required RxInt currentIndexPosition,
    CarouselController? carouselController,
    bool enableInfiniteScroll = true,
    bool enlargeCenterPage = true,
    bool disableCenter = true,
    double enlargeFactor = 0.5,
    bool autoPlay = true,
    double viewportFraction = 0.9,
    double aspectRatio = 4 / 3,
    Function(int)? onPageChanged,
    Function(double)? onTapIndicator,
    bool isUsingDotIndicator = true,
    double? heightScroll,
  }) {
    return GetBuilder<T>(
      builder: (controller) => Column(
        children: [
          CarouselSlider.builder(
            carouselController: carouselController,
            disableGesture: true,
            itemCount: itemsCount,
            itemBuilder: (context, index, realIndex) {
              return child.call(index, controller);
            },
            options: CarouselOptions(
              height: heightScroll,
              enableInfiniteScroll: enableInfiniteScroll,
              enlargeCenterPage: enlargeCenterPage,
              disableCenter: disableCenter,
              enlargeFactor: enlargeFactor,
              autoPlay: autoPlay,
              viewportFraction: viewportFraction,
              aspectRatio: aspectRatio,
              onPageChanged: (index, reason) {
                onPageChanged?.call(index);
                controller.update();
              },
              pauseAutoPlayInFiniteScroll: true,
            ),
          ),
          if (isUsingDotIndicator)
            DotsIndicator(
              onTap: (position) {
                currentIndexPosition.value = position.toInt();
                carouselController?.jumpToPage(currentIndexPosition.value);
                controller.update();
              },
              dotsCount: itemsCount,
              position: currentIndexPosition.value.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.backGroundColorButtonDefault,
              ),
            ),
        ],
      ),
    );
  }

  static Widget baseBottomSheet({
    required String title,
    required Widget body,
    Widget? iconTitle,
    bool isSecondDisplay = false,
    bool isMiniSize = false,
    Function()? onPressed,
    Widget? actionArrowBack,
    double? padding,
    bool noAppBar = false,
    Color? backgroundColor,
    TextAlign? textAlign,
  }) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(
          top: Get.mediaQuery.padding.top + (isSecondDisplay ? 100 : 20)),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.bottomSheet(),
            borderRadius: !GetPlatform.isAndroid
                ? const BorderRadius.vertical(top: Radius.circular(20))
                : null),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetConst.sizedBox5,
            noAppBar
                ? const SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AutoSizeText(title.tr,
                            textAlign: textAlign ?? TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.headline6!.copyWith(
                              color: AppColors.lightPrimaryColor,
                            )).paddingOnly(left: AppDimen.paddingHuge),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: actionArrowBack ??
                            const CloseButton(
                              color: AppColors.lightPrimaryColor,
                            ),
                      ),
                      iconTitle ?? const SizedBox(),
                    ],
                  ).paddingSymmetric(vertical: AppDimen.paddingSmall),
            isMiniSize ? body : Expanded(child: body),
          ],
        ).paddingSymmetric(horizontal: padding ?? AppDimen.defaultPadding),
      ),
    );
  }

  static Widget buildDropdown<T>({
    required Map<T, String> mapData,
    required Rx<T?> currentIndex,
    required Widget Function(String) itemWidget,
    required String defaultText,
    double? height,
    double? width,
    Color? backGroundColors,
    double? borderRadius,
    double? heightItem,
    Color? backgroundColorItem,
    Color? backGroundColorDropDown,
  }) {
    return Container(
      alignment: Alignment.center,
      height: height ?? Get.height * AppDimen.resolutionWidgetDropdownHeight,
      width: width ?? Get.width * AppDimen.resolutionWidgetDropdown,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
              borderRadius ?? AppDimen.radiusButtonDefault),
          color: backGroundColors ?? Colors.green),
      child: DropdownButtonCustom<T>(
        dropdownColor: backGroundColorDropDown,
        onChanged: (value) => {},
        items: mapData
            .map(
              (key, value) => MapEntry(
                key,
                DropdownMenuItemCustom<T>(
                  child: Container(
                    width: double.infinity,
                    height: heightItem,
                    color: backgroundColorItem,
                    child: itemWidget.call(value),
                  ),
                ),
              ),
            )
            .values
            .toList(),
        selectedItemBuilder: (context) => [
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              mapData[currentIndex.value] ?? defaultText,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(left: AppDimen.paddingVerySmall),
          )
        ],
      ),
    );
  }

  static buildRadioButton({
    required String title,
    required bool isCheck,
    required var onTap,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Icon(
            !isCheck ? Icons.radio_button_off : Icons.radio_button_checked,
            color: isCheck ? AppColors.orange : Colors.grey,
          ),
          buildText(
            title,
          ).paddingOnly(
            left: AppDimen.paddingVerySmall,
          )
        ],
      ).paddingSymmetric(
        horizontal: AppDimen.paddingSmall,
      ),
    );
  }

  //TODO: Build Input
  static Widget buildInput(TextEditingController textEditingController,
      {String label = '',
      FocusNode? focusNode,
      FocusNode? nextNode,
      bool enable = true,
      TextInputType textInputType = TextInputType.multiline,
      Widget? icon,
      Function(String)? onChanged,
      Function()? onTap,
      Function(String)? onNext,
      Function(String)? submitFunc,
      bool isRequired = false,
      InputFormatter inputFormatters = InputFormatter.none,
      TextInputAction iconNextTextInputAction = TextInputAction.next,
      Color fillColor = Colors.white,
      Color textColor = Colors.black,
      String? hintText,
      int? minLengthInputForm,
      int? maxLengthInputForm,
      TypeInput typeInput = TypeInput.none,
      bool showCounter = false,
      bool isReadOnly = false,
      IconData? iconLeading,
      double borderRadius = 20,
      EdgeInsetsGeometry? contentPadding,
      TextAlign? alignText,
      bool isUseSuffixIcon = true,
      double? widthInput,
      double? height}) {
    return SizedBox(
        width: widthInput ?? Get.width * AppDimen.resolutionWidgetTextEditing,
        child: BuildInputText(
          InputTextModel(
              height: height,
              textAlign: alignText,
              borderRadius: borderRadius,
              enable: enable,
              textColor: textColor,
              errorTextColor: AppColors.colorRed444,
              fillColor: fillColor,
              controller: textEditingController,
              currentNode: focusNode,
              contentPadding: contentPadding,
              nextNode: nextNode,
              inputFormatter: inputFormatters,
              suffixIcon: icon,
              onChanged: onChanged,
              maxLengthInputForm: maxLengthInputForm,
              onTap: onTap,
              hintText: hintText,
              onNext: onNext,
              iconLeading: iconLeading,
              isReadOnly: isReadOnly,
              isShowCounterText: showCounter,
              submitFunc: submitFunc,
              iconNextTextInputAction: iconNextTextInputAction,
              textInputType: textInputType,
              hintTextSize: AppDimen.textSizeInput,
              textSize: AppDimen.textSizeInput,
              obscureText: typeInput == TypeInput.password,
              isUseSuffixIcon: isUseSuffixIcon,
              validator: (val) {
                if (isRequired) {
                  if (val!.isStringEmpty) {
                    return "must not null";
                  }
                }
                return val.validator(typeInput, minLength: minLengthInputForm);
              }),
        ));
  }

  static void setPointerAfterText(
    TextEditingController textEditingController,
  ) {
    textEditingController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: textEditingController.text.length,
      ),
    );
  }

  static BorderRadius borderRadiusBottom({double radius = AppDimen.radius8}) {
    return BorderRadius.only(
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );
  }

  static BorderRadius borderRadiusTop({double radius = AppDimen.radius8}) {
    return BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
  }

  static Widget buildScrollList({
    required int itemsCount,
    required Widget Function(int) itemWidget,
    Axis scrollDirection = Axis.vertical,
    Widget? separatorWidget,
    double? height,
    bool isScroll = true,
  }) {
    return SizedBox(
      height: scrollDirection == Axis.horizontal ? height : null,
      child: ListView.separated(
        physics: !isScroll ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: true,
        scrollDirection: scrollDirection,
        itemCount: itemsCount,
        itemBuilder: ((context, index) {
          return itemWidget.call(index);
        }),
        separatorBuilder: (BuildContext context, int index) {
          return separatorWidget ?? const SizedBox();
        },
      ),
    );
  }

  static Widget buildListScrollWithTitle<T>({
    Function()? action,
    Widget? actionWidget,
    required Widget leading,
    required int itemsCount,
    required Widget Function(int) itemsWidget,
    required Axis scrollDirection,
    double? height,
    bool isScroll = false,
    Widget? separatorWidget,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading,
            if (actionWidget != null)
              UtilButton.baseOnAction(
                  onTap: action ?? () {}, child: actionWidget)
          ],
        ),
        WidgetConst.sizedBoxPadding,
        buildScrollList(
          itemsCount: itemsCount,
          itemWidget: itemsWidget,
          scrollDirection: scrollDirection,
          height: height,
          isScroll: isScroll,
          separatorWidget: separatorWidget,
        )
      ],
    );
  }

  static Widget buildBodyPadding(Widget body,
      {double paddingHorizontal = 0, double paddingVertical = 0}) {
    return body.paddingSymmetric(
        horizontal: paddingHorizontal, vertical: paddingVertical);
  }

  static Widget itemLine({
    Function()? func,
    double? heightLeading,
    IconData? iconLeading,
    bool isShowLeading = true,
    Widget? title,
    Widget? subtitle,
    // String? title,
    // TextStyle? titleStyle,
    // String? subtitle,
    // TextStyle? subStyle,
    Widget? trailing,
    String? urlImages,
    double? heightImagesLeading,
    double? widthImageLeading,
    double? radiusImageLeading,
    bool isUseRadius = true,
    List<BoxShadow>? boxShadow,
  }) {
    return UtilButton.baseOnAction(
        onTap: func ?? () {},
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          visualDensity: const VisualDensity(vertical: 3),
          leading: isShowLeading
              ? buildIconInItemLine(
                  boxShadow: boxShadow,
                  iconLeading: iconLeading,
                  urlImages: urlImages,
                  heightImage: heightImagesLeading,
                  widthImage: widthImageLeading,
                  radius: isUseRadius
                      ? radiusImageLeading ?? AppDimen.radius10
                      : null,
                )
              : null,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
        ));
  }

  static Widget buildIconInItemLine({
    double? heightImage,
    double? widthImage,
    String? urlImages,
    IconData? iconLeading,
    Color? colorIcon,
    double? radius,
    List<BoxShadow>? boxShadow,
  }) {
    return urlImages != null
        ? CardUtils.buildCardCustomRadiusBorder(
            radiusAll: radius,
            boxShadows: boxShadow,
            child: Container(
              height: heightImage ?? 50,
              width: widthImage ?? 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(urlImages), fit: BoxFit.cover),
              ),
            ),
          )
        : Icon(
            iconLeading,
            color: colorIcon,
          );
  }

  // static Widget buildRating(double rating, {Function()? func}) =>
  //     UtilButton.baseOnAction(
  //       onTap: func ?? () {},
  //       child: Row(
  //         children: [
  //           AutoSizeText(
  //             rating.toString(),
  //             style: Get.textTheme.bodyText1,
  //           ),
  //           Icon(
  //             Icons.star,
  //             size: AppDimens.sizeIconSmall,
  //             color: AppColors.backGroundColorButtonDefault,
  //           )
  //         ],
  //       ),
  //     );

  static Widget buildButton(
    String btnTitle,
    Function() function, {
    List<Color> colors = AppColors.colorGradientBlue,
    Color? backgroundColor,
    bool isLoading = false,
    bool showLoading = true,
    double? width,
    double? height,
    BorderRadiusGeometry? borderRadius,
    Color? textColor,
    double? fontSize,
    double? radius,
    double? paddingRight,
    MainAxisAlignment? alignment,
    AlignmentGeometry? alignmentText,
    IconData? icon,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? AppDimen.btnMedium,
      decoration: BoxDecoration(
          color: backgroundColor,
          gradient:
              backgroundColor != null ? null : LinearGradient(colors: colors),
          borderRadius: borderRadius ??
              BorderRadius.circular(radius ?? AppDimen.paddingVerySmall)),
      child: baseOnAction(
        onTap: !isLoading ? function : () {},
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? AppDimen.radius8),
            ),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: alignment ?? MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: icon != null,
                    child: Icon(
                      icon,
                      color: AppColors.textColorWhite,
                      size: 18,
                    ).paddingOnly(
                      right: paddingRight ?? AppDimen.paddingVerySmall,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: alignmentText ?? Alignment.center,
                      child: AutoSizeText(
                        btnTitle.tr,
                        style: Get.textTheme.bodyText1?.copyWith(
                          fontSize: fontSize ?? AppDimen.fontMedium(),
                          color: textColor ?? Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: isLoading,
                  child: const SizedBox(
                    height: AppDimen.btnSmall,
                    width: AppDimen.btnSmall,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.colorError,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildCustomItemLine({
    required Widget child,
    Function()? func,
    String? urlLeading,
    String? urlTrailing,
    Widget? leading,
    double? heightImage,
    double? widthImage,
    double? borderRadiusImage,
    double? spacing,
    Widget? trailing,
    bool isFromAsset = false,
    bool isFromLocalFile = false,
    bool isFromNetwork = true,
  }) {
    return UtilButton.baseOnAction(
        onTap: func ?? () {},
        child: Row(
          children: [
            urlLeading != null
                ? buildImageWidget(
                    urlLeading,
                    heightImage: heightImage,
                    widthImage: widthImage,
                    radius: borderRadiusImage,
                    isFromAsset: isFromAsset,
                    isFromLocalFile: isFromLocalFile,
                    isFromNetwork: isFromNetwork,
                  )
                : leading ?? const SizedBox(),
            WidgetConst.sizedBox(width: spacing),
            Expanded(child: child),
            WidgetConst.sizedBox(width: spacing),
            urlTrailing != null
                ? buildImageWidget(
                    urlTrailing,
                    heightImage: heightImage,
                    widthImage: widthImage,
                    radius: borderRadiusImage,
                    isFromAsset: isFromAsset,
                    isFromLocalFile: isFromLocalFile,
                    isFromNetwork: isFromNetwork,
                  )
                : trailing ?? const SizedBox(),
          ],
        ));
  }

  ///Default images from network
  static Widget buildImageWidget(
    String urlImages, {
    bool isFromNetwork = true,
    bool isFromAsset = false,
    bool isFromLocalFile = false,
    double? heightImage,
    double? widthImage,
    double? radius,
    Function? func,
  }) {
    return CardUtils.buildCardCustomRadiusBorder(
      function: func,
      radiusAll: radius,
      child: Container(
        height: heightImage ?? 50,
        width: widthImage ?? 50,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: (isFromNetwork
                  ? NetworkImage(urlImages)
                  : isFromAsset
                      ? AssetImage(urlImages)
                      : isFromLocalFile
                          ? FileImage(File(urlImages))
                          : null) as ImageProvider),
        ),
      ),
    );
  }

  static Widget baseOnAction({
    required Function onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        DateTime now = DateTime.now();
        if (_dateTime == null ||
            now.difference(_dateTime ?? DateTime.now()) > 2.seconds ||
            onTap.hashCode != _oldFunc) {
          _dateTime = now;
          _oldFunc = onTap.hashCode;
          onTap();
        }
      },
      child: child,
    );
  }

  static Widget buildAction({
    required String text,
    TextStyle? textStyle,
    IconData? iconData,
    double? iconSize,
    Color colorIcon = Colors.white,
    Function()? func,
    String? urlImage,
    bool isFromAsset = false,
    bool isFromLocalFile = false,
    bool isFromNetwork = true,
    double? spaceAround,
  }) {
    return UtilButton.baseOnAction(
      onTap: func ?? () {},
      child: Row(
        children: [
          AutoSizeText(
            text,
            style: textStyle ?? Get.textTheme.bodyText1!,
          ),
          WidgetConst.sizedBox(width: spaceAround),
          urlImage != null
              ? buildImageWidget(
                  urlImage,
                  heightImage: iconSize,
                  widthImage: iconSize,
                  isFromAsset: isFromAsset,
                  isFromLocalFile: isFromLocalFile,
                  isFromNetwork: isFromNetwork,
                )
              : Icon(
                  iconData,
                  size: iconSize,
                  color: colorIcon,
                ),
        ],
      ),
    );
  }

  static Widget buildTitle(
      {required String text, bool isBold = true, Color? colorText}) {
    return AutoSizeText(
      text,
      style: Get.textTheme.titleLarge!.copyWith(
        fontWeight: isBold ? FontWeight.bold : null,
        color: colorText,
      ),
    );
  }

  static Widget buildDividerDefault() {
    return const Divider(
      height: 10,
      thickness: 1,
      indent: AppDimen.paddingSmall,
      endIndent: AppDimen.paddingSmall,
    );
  }

  static Widget buildDivider({
    double height = 1.0,
    double thickness = 1.0,
    double indent = 0.0,
    double endIndent = 1.0,
  }) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
