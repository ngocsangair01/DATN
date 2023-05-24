import 'package:dio/dio.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/base/repositories/base_request.dart';
import 'package:tourist_app/cores/values/url_strings.dart';
import 'package:tourist_app/features/sign_up/models/sign_up_request.dart';

import '../../../base/repositories/base_repository.dart';

class SignUpRepository extends BaseRepository {
  SignUpRepository(BaseGetXController controller) : super(controller);

  Future<BaseResponse> signUp(SignUpRequest request) async {
    var response = await baseSendRequest(
      ApiUrl.urlSignUp,
      RequestMethod.POST,
      jsonMap: request.toJson(),
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
