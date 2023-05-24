import 'package:dio/dio.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/base/repositories/base_repository.dart';
import 'package:tourist_app/base/repositories/base_request.dart';
import 'package:tourist_app/cores/values/url_strings.dart';
import 'package:tourist_app/features/login/models/login_request.dart';

class LoginRepository extends BaseRepository {
  LoginRepository(BaseGetXController controller) : super(controller);

  Future<BaseResponse> login(LoginRequestModel loginRequestModel) async {
    var response = await baseSendRequest(
      ApiUrl.urlLogin,
      RequestMethod.POST,
      jsonMap: loginRequestModel.toJson(),
      functionError: (error) {
        if (error is DioError) {
          if (error.response != null) {
            controller.showSnackBar(error.response!.data["reasons"].toString(),
                isSuccess: false);
          }
        }
      },
    );
    return BaseResponse.fromJson(response);
  }
}
