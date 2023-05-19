import 'package:dio/dio.dart';
import 'package:tourist_app/base/models/base_request_page_size.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/features/destination/models/comment_destination_response.dart';
import 'package:tourist_app/features/destination/models/create_comment_destination.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/models/destination_request.dart';
import 'package:tourist_app/features/weather/models/base_request_list_model.dart';

import '../../../base/controllers/src_controller.dart';
import '../../../base/models/base_response_list.dart';
import '../../../base/repositories/base_repository.dart';
import '../../../base/repositories/base_request.dart';
import '../../../cores/values/url_strings.dart';
import '../models/destination_by_province_request.dart';

class DestinationRepository extends BaseRepository {
  DestinationRepository(BaseGetXController controller) : super(controller);

  Future<BaseResponseList<DestinationModel>> getListDestinationByProvince(
      DestinationByProvinceRequest destinationByProvinceRequest) async {
    var response = await baseSendRequest(
      ApiUrl.urlGetDestinationByProvince,
      RequestMethod.GET,
      jsonMap: destinationByProvinceRequest.toJson(),
    );
    print(response);
    return BaseResponseList<DestinationModel>.fromJson(
        response, (x) => DestinationModel.fromJson(x));
  }

  Future<BaseResponse<DestinationModel>> getDetailDestination(int id) async {
    var response = await baseSendRequest(
      "${ApiUrl.urlDestination}/$id",
      RequestMethod.GET,
    );
    BaseResponse<DestinationModel> result =
        BaseResponse<DestinationModel>.fromJson(
      response,
      func: (x) => DestinationModel.fromJson(x),
    );
    return result;
  }

  Future<BaseResponseList<DestinationModel>> getListDestinationByCreateAt(
      BaseRequestPageSize baseRequestPageSize) async {
    var response = await baseSendRequest(
      ApiUrl.urlGetDestinationByCreateAt,
      RequestMethod.GET,
      jsonMap: baseRequestPageSize.toJson(),
    );
    return BaseResponseList<DestinationModel>.fromJson(
        response, (x) => DestinationModel.fromJson(x));
  }

  Future<BaseResponse<CommentDestinationResponse>> createCommentDestination(
      CreateCommentDestination commentDestination) async {
    FormData formDestination = FormData.fromMap(commentDestination.toJson());
    var response = await baseSendRequest(
      ApiUrl.urlCommentDestination,
      RequestMethod.POST,
      jsonMap: formDestination,
    );
    return BaseResponse.fromJson(
      response,
      func: (x) => CommentDestinationResponse.fromJson(x),
    );
  }

  Future<BaseResponseList<DestinationModel>> getListDestination(
      BaseRequestListModel baseRequestListModel) async {
    var response = await baseSendRequest(
      ApiUrl.urlDestination,
      RequestMethod.GET,
      jsonMap: baseRequestListModel.toJson(),
    );
    return BaseResponseList<DestinationModel>.fromJson(
      response,
      (x) => DestinationModel.fromJson(x),
    );
  }

  Future<BaseResponseList<DestinationModel>> getListDestinationByUser(
      int idUser) async {
    var response = await baseSendRequest(
      '${ApiUrl.urlGetDestinationByIdUser}/$idUser',
      RequestMethod.GET,
    );
    return BaseResponseList<DestinationModel>.fromJson(
      response,
      (x) => DestinationModel.fromJson(x),
    );
  }

  Future<BaseResponse<DestinationModel>> createDestination(
      DestinationRequest destinationRequest) async {
    FormData formDestination =
        FormData.fromMap(await destinationRequest.toJson());
    var response = await baseSendRequest(
      ApiUrl.urlDestination,
      RequestMethod.POST,
      jsonMap: formDestination,
    );
    BaseResponse<DestinationModel> result =
        BaseResponse<DestinationModel>.fromJson(
      response,
      func: (x) => DestinationModel.fromJson(x),
    );
    return result;
  }
}
