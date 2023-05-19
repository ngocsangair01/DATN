import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';
import 'package:tourist_app/features/itinerary/models/itinerary_request.dart';
import 'package:tourist_app/features/itinerary/models/itinerary_response.dart';
import 'package:tourist_app/features/itinerary/repositories/itinerary_repository.dart';

abstract class ItineraryCtrl extends BasePageSearchController {
  
  final formKey = GlobalKey<FormState>();
  late final ItineraryRepository itineraryRepository;
  ItineraryResponse? itineraryResponse;
  late ItineraryRequest itineraryRequest;
  RxList<DestinationOutput>? destinationOutputs = RxList();
  RxList<TimelineModel> timelineItems = RxList();
  TextEditingController maxDestinationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString travelMode = "driving".obs;
  RxList<TimelineModel> listItineraryShow = RxList();
  ItineraryCtrl(String? address) {
    itineraryRepository = ItineraryRepository(this);
    addressController.text = address ?? "";
    itineraryRequest = ItineraryRequest(
      address: "",
      maxDestination: 0,
      travelMode: "driving",
    );
  }
  Future<void> getItinerary();
}
