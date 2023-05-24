import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/features/destination/models/province_model.dart';
import 'package:tourist_app/features/map/controllers/map_ctrl.dart';
import 'package:tourist_app/features/map/models/address_request_list.dart';
import 'package:tourist_app/features/map/models/address_response.dart';
import 'package:tourist_app/features/map/models/api_map_model.dart';
import 'package:tourist_app/features/map/models/display_itinenary_request.dart';
import 'package:tourist_app/features/weather/models/base_request_list_model.dart';
import '../../../base/models/base_response_list.dart';
import '../../../features/weather/utils/extension.dart';
import '../models/display_itinenary_model.dart';

class MapCtrlImp extends MapCtrl {
  MapCtrlImp(DisplayItineraryRequest? displayItineraryRequest)
      : super(itineraryRequestArg: displayItineraryRequest);
  @override
  Future<void> onInit() async {
    if (startLatDisplay != null) {
      await fetchRoute();
    }
    super.onInit();
  }

  @override
  Future<void> searchLocations() async {
    if (searchQuery.isNotEmpty) {
      ApiMapModel apiMapModel = await mapApiRepository.searchMap(searchQuery);
      if (apiMapModel.status == "OK") {
        final location = apiMapModel.results?[0].geometry?.location;
        final latLng = LatLng(location?.lat ?? 0, location?.lng ?? 0);
        mapController.value?.animateCamera(CameraUpdate.newLatLng(latLng));
        markers.clear();
        markers.add(Marker(
          markerId: MarkerId('selected'),
          position: latLng,
        ));
      }
    }
  }

  @override
  void selectedMarker(LatLng latLng) async {
    markers.clear();
    markers.add(
      Marker(markerId: MarkerId('selected'), position: latLng),
    );
  }

  @override
  void onMapCreated(GoogleMapController controller) {
    // set initial map location
    mapController.value = controller;
    mapController.value?.animateCamera(CameraUpdate.newCameraPosition(
      const CameraPosition(target: LatLng(21.0277644, 105.8341598), zoom: 12),
    ));
  }

  @override
  Future<void> showSelectedMarker() async {
    if (markers.isNotEmpty) {
      try {
        showLoadingSubmit();
        final marker = markers.first;
        ApiMapModel apiMapModel = await mapApiRepository.getInformationByLatLng(
            marker.position.latitude, marker.position.longitude);
        if (apiMapModel.status == 'OK') {
          address = apiMapModel.results?[0].formattedAddress;
          final provinceFromMap = apiMapModel.results?[0].addressComponents
              ?.firstWhere(
                (element) =>
                    element.types!.contains("administrative_area_level_1"),
              )
              .longName
              ?.formatSlug()
              .toLowerCase();
          BaseResponseList<ProvinceModel> provincesResponse =
              await provinceRepository.getListProvince(
            BaseRequestListModel(
              keyword: "",
              page: 0,
              size: 63,
            ),
          );
          List<ProvinceModel> provinces = provincesResponse.data;
          for (var province in provinces) {
            if (province.nameShort?.compareTo(provinceFromMap ?? "") == 0) {
              idProvince = province.id ?? 0;
            }
          }
          AddressRequestList addressRequestList = AddressRequestList(
              idProvince: idProvince, keyword: address, page: 0, size: 10);
          var response =
              await addressRepository.findAddress(addressRequestList);
          if (response.restStatus == "SUCCESS") {
            if (response.data.isNotEmpty) {
              Get.back(result: response.data[0]);
            } else {
              Get.back(
                result: AddressResponse(
                  id: response.data[0].id,
                  detailAddress: address,
                  longitude: marker.position.longitude,
                  latitude: marker.position.latitude,
                ),
              );
            }
          }
        }
      } finally {
        hideLoadingSubmit();
      }
    }
  }

  @override
  Future<void> fetchRoute() async {
    DisplayItineraryRequest displayItineraryRequest = DisplayItineraryRequest(
      startLat: startLatDisplay,
      startLng: startLngDisplay,
      endLat: endLatDisplay,
      endLng: endLngDisplay,
      travelMode: travelMode,
    );
    var response =
        await mapApiRepository.displayItinerary(displayItineraryRequest);
    if (response.status == "OK") {
      List<LatLng> routePoints = [];
      List<Step> steps = response.routes[0].legs[0].steps;
      for (int i = 0; i < steps.length; i++) {
        double startLat = steps[i].startLocation?.lat ?? 0;
        double startLng = steps[i].startLocation?.lng ?? 0;
        routePoints.add(LatLng(startLat, startLng));
        if (i == steps.length - 1) {
          double endLat = steps[i].endLocation?.lat ?? 0;
          double endLng = steps[i].endLocation?.lng ?? 0;
          routePoints.add(LatLng(endLat, endLng));
        }
        int durationTemp = steps[i].duration?.value ?? 0;
        duration.value += durationTemp;
        int distanceTemp = steps[i].distance?.value ?? 0;
        distance.value += distanceTemp;
      }
      print(duration.value);
      print(distance.value);
      PolylineId id = const PolylineId("route");
      LatLngBounds bounds = getBounds(routePoints);
      mapController.value
          ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      Polyline polyline = Polyline(
        polylineId: id,
        color: AppColors.baseColorGreen,
        points: routePoints,
      );
      polylines[id] = polyline;

      final latLng = LatLng(endLatDisplay ?? 0, endLngDisplay ?? 0);
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('selected'),
        position: latLng,
      ));
    }
  }

  @override
  LatLngBounds getBounds(List<LatLng> routePoints) {
    double minLat = double.infinity;
    double maxLat = -double.infinity;
    double minLng = double.infinity;
    double maxLng = -double.infinity;
    for (LatLng point in routePoints) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  Future<void> getLocationInfo() async {
    try {
      showLoadingSubmit2();
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latLng = LatLng(position.latitude, position.longitude);
      mapController.value?.animateCamera(CameraUpdate.newLatLng(latLng));
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selected'),
          position: latLng,
        ),
      );
    } on PlatformException catch (e) {
      showSnackBar('Error: ${e.message}');
    } finally {
      hideLoadingSubmit2();
    }
  }
}
