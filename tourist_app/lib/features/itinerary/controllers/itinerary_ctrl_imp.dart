import 'package:get/get.dart';

import '../../map/models/display_itinenary_request.dart';
import '../../map/uis/map_page.dart';
import 'itinerary_ctrl.dart';

class ItineraryCtrlImp extends ItineraryCtrl {
  ItineraryCtrlImp(String? address) : super(address);

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> functionSearch() async {}

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {}

  @override
  Future<void> getItinerary() async {
    if (formKey.currentState!.validate()) {
      try {
        showLoadingSubmit();
        itineraryRequest
          ..address = addressController.text
          ..maxDestination = int.parse(maxDestinationController.text)
          ..travelMode = travelMode.value;
        var response =
            await itineraryRepository.recommendItinerary(itineraryRequest);
        if (response.data != null) {
          itineraryResponse = response.data;
          // latOrigin = itineraryResponse?.address?.latitude;
          // lngOrigin = itineraryResponse?.address?.longitude;
          destinationOutputs?.value =
              itineraryResponse?.listDestinationDataOutput ?? [];
          listDistance?.value = itineraryResponse?.listDistance ?? [];
          listTime?.value = itineraryResponse?.listTime ?? [];
        }
      } finally {
        hideLoadingSubmit();
      }
    }
  }

  @override
  void requestItineraryLatLng(int index) {
    if (index == 0) {
      latOrigin = itineraryResponse?.addressDataOutput?.latitude;
      lngOrigin = itineraryResponse?.addressDataOutput?.longitude;
    } else {
      latOrigin = destinationOutputs?[index - 1].address?.latitude;
      lngOrigin = destinationOutputs?[index - 1].address?.longitude;
    }
    DisplayItineraryRequest request = DisplayItineraryRequest(
      startLat: latOrigin,
      startLng: lngOrigin,
      endLat: destinationOutputs?[index].address?.latitude,
      endLng: destinationOutputs?[index].address?.longitude,
      travelMode: travelMode.value,
    );
    Get.to(
      MapPage(
        displayItineraryRequest: request,
      ),
    );
  }
}
