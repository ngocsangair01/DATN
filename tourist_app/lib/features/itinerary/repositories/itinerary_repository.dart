import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/base/repositories/base_repository.dart';
import 'package:tourist_app/base/repositories/base_request.dart';
import 'package:tourist_app/cores/values/url_strings.dart';
import 'package:tourist_app/features/itinerary/models/itinerary_request.dart';

import '../models/itinerary_response.dart';

class ItineraryRepository extends BaseRepository {
  ItineraryRepository(BaseGetXController controller) : super(controller);

  Future<BaseResponse<ItineraryResponse>> recommendItinerary(
      ItineraryRequest request) async {
    var response = await baseSendRequest(
      ApiUrl.urlRecommendItinerary,
      RequestMethod.POST,
      jsonMap: request.toJson(),
    );
    BaseResponse<ItineraryResponse> result =
        BaseResponse<ItineraryResponse>.fromJson(
      response,
      func: (x) => ItineraryResponse.fromJson(x),
    );
    return result;
  }
}
