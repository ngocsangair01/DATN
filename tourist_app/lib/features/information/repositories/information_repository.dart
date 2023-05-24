import 'package:dio/dio.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/base/repositories/base_repository.dart';
import 'package:tourist_app/features/information/models/user_response.dart';

import '../../../base/models/base_response.dart';
import '../../../base/repositories/base_request.dart';
import '../../../cores/values/url_strings.dart';
import '../models/user_request.dart';

class InformationRepository extends BaseRepository {
  InformationRepository(BaseGetXController controller) : super(controller);
  Future<BaseResponse<UserResponse>> saveUser(
      UserRequest request, int idUser) async {
    var response = await baseSendRequest(
      "${ApiUrl.urlUser}/$idUser",
      RequestMethod.PUT,
      jsonMap: request.toJson(),
    );
    BaseResponse<UserResponse> result = BaseResponse<UserResponse>.fromJson(
      response,
      func: (x) => UserResponse.fromJson(x),
    );
    return result;
  }

  Future<BaseResponse<UserResponse>> getDetailUserById(int id) async {
    var response = await baseSendRequest(
      "${ApiUrl.urlUser}/$id",
      RequestMethod.GET,
    );
    BaseResponse<UserResponse> result = BaseResponse<UserResponse>.fromJson(
      response,
      func: (x) => UserResponse.fromJson(x),
    );
    return result;
  }
}
