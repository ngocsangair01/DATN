import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/base/repositories/base_request.dart';
import 'package:tourist_app/cores/values/url_strings.dart';
import 'package:tourist_app/features/weather/models/lat_lng_request.dart';
import 'package:tourist_app/features/weather/models/weather_response_list_model.dart';
import 'package:tourist_app/features/weather/models/weather_response_model.dart';

import '../../../base/controllers/src_controller.dart';
import '../../../base/repositories/base_repository.dart';
import '../models/base_request_list_model.dart';

class WeatherRepository extends BaseRepository {
  WeatherRepository(BaseGetXController controller) : super(controller);

  Future<BaseResponseList<WeatherResponseListModel>> getListCurrentWeather(
      BaseRequestListModel weatherRequestListModel) async {
    var response = await baseSendRequest(
      ApiUrl.urlWeather,
      RequestMethod.GET,
      jsonMap: weatherRequestListModel.toJson(),
    );
    return BaseResponseList<WeatherResponseListModel>.fromJson(
        response, (x) => WeatherResponseListModel.fromJson(x));
  }

  Future<BaseResponse<WeatherResponseModel>> getListWeatherForecast(
      int idProvince) async {
    var response = await baseSendRequest(
      '${ApiUrl.urlWeather}/${idProvince.toString()}',
      RequestMethod.GET,
    );
    BaseResponse<WeatherResponseModel> result =
        BaseResponse<WeatherResponseModel>.fromJson(
      response,
      func: (x) => WeatherResponseModel.fromJson(x),
    );
    return result;
  }

  Future<BaseResponse<WeatherResponseModel>> getListWeatherForecastLatLng(
      LatLngRequest latLngRequest) async {
    var response = await baseSendRequest(
      ApiUrl.urlWeatherLatLng,
      RequestMethod.GET,
      jsonMap: latLngRequest.toJson(),
    );
    print(response);
    BaseResponse<WeatherResponseModel> result =
        BaseResponse<WeatherResponseModel>.fromJson(
      response,
      func: (x) => WeatherResponseModel.fromJson(x),
    );
    return result;
  }
}
