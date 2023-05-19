import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/base/repositories/base_repository.dart';
import 'package:tourist_app/base/repositories/base_request.dart';
import 'package:tourist_app/cores/values/url_strings.dart';
import 'package:tourist_app/features/destination/models/province_model.dart';
import 'package:tourist_app/features/weather/models/base_request_list_model.dart';

class ProvinceRepository extends BaseRepository {
  ProvinceRepository(BaseGetXController controller) : super(controller);

  Future<BaseResponseList<ProvinceModel>> getListProvince(
      BaseRequestListModel baseRequestListModel) async {
    var response = await baseSendRequest(
      ApiUrl.urlProvince,
      RequestMethod.GET,
      jsonMap: baseRequestListModel.toJson(),
    );
    return BaseResponseList<ProvinceModel>.fromJson(
        response, (x) => ProvinceModel.fromJson(x));
  }
}
