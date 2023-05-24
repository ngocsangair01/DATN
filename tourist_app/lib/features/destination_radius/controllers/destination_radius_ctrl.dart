import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/base_page_search_controller.dart';
import 'package:tourist_app/features/destination/models/destination_radius_request.dart';
import 'package:tourist_app/features/destination/models/destination_radius_response.dart';
import 'package:tourist_app/features/destination/repositories/destination_repository.dart';

abstract class DestinationRadiusCtrl
    extends BasePageSearchController<DestinationRadiusResponse> {
  final formKey = GlobalKey<FormState>();
  late DestinationRepository destinationRepository;
  TextEditingController addressController = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  DestinationRadiusRequest destinationRadiusRequest =
      DestinationRadiusRequest();
  // Rx<DestinationRadiusResponse> destinationRadiusResponse = Rx(DestinationRadiusResponse());
  RxList<ListDestinationDataOutput> listDestinationDataOutput = RxList([]);
  RxList<double> listDistance = RxList([]);
  RxString travelMode = "driving".obs;

  double? latOrigin;
  double? lngOrigin;

  DestinationRadiusCtrl() {
    destinationRepository = DestinationRepository(this);
  }

  Future<void> searchDestination();

  void requestItineraryLatLng(int index);
}
