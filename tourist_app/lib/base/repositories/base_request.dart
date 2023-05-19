import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../cores/apps/app_controller.dart';
import '../../cores/values/const.dart';
import '../../cores/values/url_strings.dart';
import '../controllers/src_controller.dart';

enum RequestMethod { POST, GET, PUT, DELETE, PATCH }

class BaseRequest {
  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options = buildDefaultOptions();

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static BaseOptions buildDefaultOptions() {
    return BaseOptions()
      ..connectTimeout = const Duration(milliseconds: AppConst.requestTimeOut)
      ..receiveTimeout = const Duration(milliseconds: AppConst.requestTimeOut);
  }

  static void close() {
    dio.close(force: true);
    updateCurrentDio();
  }

  static void updateCurrentDio() {
    dio = getBaseDio();
  }

  static Dio getCurrentDio() {
    return dio;
  }

  void setOnErrorListener(Function(Object error) onErrorCallBack) {
    this.onErrorCallBack = onErrorCallBack;
  }

  late Function(Object error) onErrorCallBack;

  /// [isQueryParametersPost]: `true`: phương thức post gửi params, mặc định = `false`
  ///
  /// [dioOptions]: option của Dio() sử dụng khi gọi api có option riêng
  ///
  /// [functionError]: chạy function riêng khi request xảy ra Exception (mặc định sử dụng [showDialogError])
  Future<dynamic> sendRequest(String action, RequestMethod requestMethod,
      {dynamic jsonMap,
      bool isDownload = false,
      String? urlOther,
      Map<String, String>? headersUrlOther,
      bool isQueryParametersPost = false,
      required BaseGetXController controller,
      BaseOptions? dioOptions,
      Function(Object error)? functionError}) async {
    dio.options = dioOptions ?? buildDefaultOptions();

    var response;

    String url = urlOther ?? (ApiUrl.urlBase + action);
    Map<String, String> headers = headersUrlOther ?? await getBaseHeader();

    Options options = isDownload
        ? Options(
            headers: headers,
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status != null && status < 500;
            })
        : Options(
            headers: headers,
            method: requestMethod.toString(),
            responseType: ResponseType.json,
          );

    CancelToken _cancelToken = CancelToken();
    controller.addCancelToken(_cancelToken);
    try {
      if (requestMethod == RequestMethod.POST) {
        if (isQueryParametersPost) {
          response = await dio.post(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: _cancelToken,
          );
        } else {
          response = await dio.post(
            url,
            data: jsonMap,
            options: options,
            cancelToken: _cancelToken,
          );
        }
      } else if (requestMethod == RequestMethod.PUT) {
        response = await dio.put(
          url,
          data: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      } else if (requestMethod == RequestMethod.DELETE) {
        response = await dio.delete(
          url,
          data: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      } else if (requestMethod == RequestMethod.PATCH) {
        response = await dio.patch(
          url,
          data: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      } else {
        response = await dio.get(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: _cancelToken,
        );
      }
      return response.data;
    } catch (e) {
      controller.cancelRequest(_cancelToken);

      return functionError != null ? functionError(e) : showDialogError(e);
    }
  }

  dynamic showDialogError(dynamic e) {
    if (e.response?.data != null &&
        e.response.data is Map &&
        e.response.data["data"] != null) return e.response.data;
    onErrorCallBack(e);
  }

  Future<Map<String, String>> getBaseHeader() async {
    String authentication = HIVE_APP.get(AppConst.keyToken) ?? "";
    return {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $authentication',
    };
  }
}
