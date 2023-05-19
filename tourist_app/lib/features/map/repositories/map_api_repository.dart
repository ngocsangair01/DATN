import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/base/repositories/base_repository.dart';
import 'package:tourist_app/base/repositories/base_request.dart';

import '../../../cores/apps/app_controller.dart';
import '../models/api_map_model.dart';

class MapApiRepository extends BaseRepository {
  MapApiRepository(BaseGetXController controller) : super(controller);

  Future<ApiMapModel> searchMap(String searchQuery) async {
    var response = await baseSendRequest('', RequestMethod.GET,
        urlOther:
            'https://maps.googleapis.com/maps/api/geocode/json?address=$searchQuery&key=${HIVE_APP.get('apiGoogle')}');
    return ApiMapModel.fromJson(response);
  }

  Future<ApiMapModel> getInformationByLatLng(double lat, double lng) async {
    var response = await baseSendRequest('', RequestMethod.GET,
        urlOther:
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${HIVE_APP.get('apiGoogle')}');
    return ApiMapModel.fromJson(response);
  }
}
