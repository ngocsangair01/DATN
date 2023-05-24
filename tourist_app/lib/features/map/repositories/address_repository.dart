import 'package:dio/dio.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/base/repositories/base_repository.dart';
import 'package:tourist_app/base/repositories/base_request.dart';
import 'package:tourist_app/cores/values/url_strings.dart';
import 'package:tourist_app/features/map/models/address_request.dart';
import 'package:tourist_app/features/map/models/address_request_list.dart';
import 'package:tourist_app/features/map/models/address_response.dart';

class AddressRepository extends BaseRepository {
  AddressRepository(BaseGetXController controller) : super(controller);

  Future<BaseResponse<AddressResponse>> createAddress(
      AddressRequest addressRequest) async {
    var response = await baseSendRequest(
      ApiUrl.urlAddress,
      RequestMethod.POST,
      jsonMap: addressRequest.toJson(),
    );
    BaseResponse<AddressResponse> result =
        BaseResponse<AddressResponse>.fromJson(
      response,
      func: (x) => AddressResponse.fromJson(x),
    );
    return result;
  }

  Future<BaseResponseList<AddressResponse>> findAddress(
      AddressRequestList addressRequestList) async {
    var response = await baseSendRequest(
      ApiUrl.urlAddress,
      RequestMethod.GET,
      jsonMap: addressRequestList.toJson(),
    );
    BaseResponseList<AddressResponse> result =
        BaseResponseList<AddressResponse>.fromJson(
            response, (x) => AddressResponse.fromJson(x));
    return result;
  }
}
