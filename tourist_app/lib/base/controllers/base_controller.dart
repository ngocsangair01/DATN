import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cores/themes/colors.dart';
import '../../cores/values/const.dart';
import '../../cores/values/strings.dart';
import '../repositories/base_request.dart';

class BaseGetXController extends GetxController {
  RxBool isShowLoading = false.obs;
  RxBool isShowLoadingSubmit = false.obs;
  RxBool isShowLoadingSubmit2 = false.obs;
  String errorContent = '';
  BaseRequest baseRequestController = Get.find();

  ///1 CancelToken để huỷ 1 request.
  ///1 màn hình gắn với 1 controller, 1 controller có nhiều requests khi huỷ 1 màn hình => huỷ toàn bộ requests `UNCOMPLETED` tại màn hình đó.
  List<CancelToken> cancelTokens = [];

  /// Sử dụng một số màn bắt buộc sử dụng loading overlay
  RxBool isLoadingOverlay = false.obs;

  /// Sử dụng cho demo78 phát hành hóa đơn có mã
  RxBool isLoadingOverlayIssue = false.obs;

  /// Sử dụng cho demo78 phát hành thành công hóa đơn
  RxBool isIssueSuccess = false.obs;

  // RxBool isDarkMode = RxBool(APP_DATA.read(AppConst.keyIsDarkTheme) ?? false);

  // RxBool isLanguageVN = RxBool(APP_DATA.read(AppConst.keyLanguageIsVN) ?? true);

  void showLoading() {
    isShowLoading.value = true;
  }

  void hideLoading() {
    isShowLoading.value = false;
  }

  void showLoadingSubmit() {
    isShowLoadingSubmit.value = true;
  }

  void hideLoadingSubmit() {
    isShowLoadingSubmit.value = false;
  }

  void showLoadingSubmit2() {
    isShowLoadingSubmit2.value = true;
  }

  void hideLoadingSubmit2() {
    isShowLoadingSubmit2.value = false;
  }

  void showLoadingOverlay() {
    isLoadingOverlay.value = true;
  }

  void hideLoadingOverlay() {
    isLoadingOverlay.value = false;
  }

  void _setOnErrorListener() {
    baseRequestController.setOnErrorListener((error) {
      errorContent = AppStr.errorConnectFailedStr.tr;

      if (error is DioError) {
        //Nếu server có trả về message thì hiển thị
        if (error.response?.data != null &&
            error.response!.data is Map &&
            error.response!.data["message"] != null) {
          errorContent = error.response!.data['message'];
        } else {
          switch (error.type) {
            case DioErrorType.sendTimeout:
            case DioErrorType.receiveTimeout:
              errorContent = AppStr.errorConnectTimeOut.tr;
              break;
            case DioErrorType.cancel:
              // không hiện thông báo khi huỷ request
              errorContent = '';
              break;
            case DioErrorType.badResponse:
              errorContent = 'bad response';
              break;

            case DioErrorType.connectionError:
              errorContent = 'Connection Error';
              break;
            case DioErrorType.badCertificate:
            case DioErrorType.unknown:

            default:
              switch (error.response!.statusCode) {
                case AppConst.error400:
                  break;
                case AppConst.error401:
                  errorContent = AppStr.error401.tr;
                  break;
                case AppConst.error404:
                  errorContent = AppStr.error404.tr;
                  break;
                case AppConst.error500:
                  errorContent = AppStr.errorInternalServer.tr;
                  break;
                case AppConst.error502:
                  errorContent = AppStr.error502.tr;
                  break;
                case AppConst.error503:
                  errorContent = AppStr.error503.tr;
                  break;
                default:
                  errorContent = AppStr.errorInternalServer.tr;
              }
              break;
          }
          // check lỗi khi tải pdf
          if (error.response?.data != null &&
              error.response?.data is List<int>) {
            var result = utf8.decode(error.response?.data);
            var err = jsonDecode(result);
            if (err is Map) {
              errorContent = err['Message'];
            }
          }
        }
      }

      isShowLoading.value = false;
      isLoadingOverlay.value = false;
      // if (errorContent.isNotEmpty) showSnackBar(errorContent);
      if (errorContent.isNotEmpty) {}
    });
  }

  Future<void> showSnackBar<T>(
    String message, {
    Duration duration = const Duration(seconds: 2),
    Widget? mainButton,
    Color? backgroundColor,
    bool? isSuccess,
  }) async {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isSuccess != null
          ? isSuccess
              ? AppColors.colorSuccessGreen
              : AppColors.colorRed444
          : AppColors.appBarColor(),
      messageText: Text(
        message.tr,
        style: Get.textTheme.bodyText1!.copyWith(
          color: isSuccess != null
              ? AppColors.textColorWhite
              : AppColors.textColor(),
        ),
      ),
      message: message.tr,
      mainButton: Row(
        children: [
          if (mainButton != null) mainButton,
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.close,
              color: isSuccess != null
                  ? AppColors.textColorWhite
                  : AppColors.textColor(),
            ),
          ),
        ],
      ),
      duration: message.length > 100 ? 5.seconds : duration,
    ));
  }

  void addCancelToken(CancelToken cancelToken) {
    cancelTokens.add(cancelToken);
  }

  void cancelRequest(CancelToken cancelToken) {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel('Cancel when close controller!!!');
    }
  }

  // void changeTheme() {
  //   // Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);

  //   // isDarkMode.toggle();
  //   // APP_DATA.write(AppConst.keyIsDarkTheme, isDarkMode.value);
  //   Get.forceAppUpdate();
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //       systemNavigationBarColor: AppColors.statusBarColor(),
  //       statusBarColor: AppColors.statusBarColor()));
  // }

  // void changeLang() {
  //   // isLanguageVN.toggle();
  //   // APP_DATA.write(AppConst.keyLanguageIsVN, isLanguageVN.value);
  // }

  @override
  void onClose() {
    for (var cancelToken in cancelTokens) {
      cancelRequest(cancelToken);
    }
    super.onClose();
  }

  @override
  void onInit() {
    _setOnErrorListener();
    super.onInit();
  }
}
