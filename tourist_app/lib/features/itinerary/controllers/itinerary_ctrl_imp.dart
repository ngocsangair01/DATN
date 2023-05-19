import 'package:flutter/cupertino.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:tourist_app/features/itinerary/models/itinerary_response.dart';

import '../../../cores/utils/widget/base_widget/card_items.dart';
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
      showLoadingSubmit();
      itineraryRequest
        ..address = addressController.text
        ..maxDestination = int.parse(maxDestinationController.text)
        ..travelMode = travelMode.value;
      var response =
          await itineraryRepository.recommendItinerary(itineraryRequest);
      if (response.data != null) {
        itineraryResponse = response.data;
        destinationOutputs?.value =
            itineraryResponse?.listDestinationOutput ?? [];
        timelineItems.value = destinationOutputs?.map((destinationOutput) {
              return TimelineModel(
                CardUtils.buildCardCustomRadiusBorder(
                  child: SizedBox(
                    height: 100,
                    child: CardUtils.buildContentInCard(
                      radius: 20,
                      url: destinationOutput.images?[0] ?? "",
                      cardInfo: const SizedBox(),
                    ),
                  ),
                ),
              );
            }).toList() ??
            [];
      }
      hideLoadingSubmit();
    }
  }
}
