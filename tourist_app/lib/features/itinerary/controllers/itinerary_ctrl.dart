import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';
import 'package:tourist_app/features/itinerary/models/itinerary_request.dart';
import 'package:tourist_app/features/itinerary/models/itinerary_response.dart';
import 'package:tourist_app/features/itinerary/repositories/itinerary_repository.dart';

abstract class ItineraryCtrl extends BasePageSearchController {
  final formKey = GlobalKey<FormState>();
  late final ItineraryRepository itineraryRepository;
  ItineraryResponse? itineraryResponse;
  late ItineraryRequest itineraryRequest;
  RxList<ListDestinationDataOutput>? destinationOutputs = RxList();
  RxList<double>? listTime = RxList();
  RxList<double>? listDistance = RxList();
  double? latOrigin;
  double? lngOrigin;
  TextEditingController maxDestinationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString travelMode = "driving".obs;
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
  void requestItineraryLatLng(int index);
}
