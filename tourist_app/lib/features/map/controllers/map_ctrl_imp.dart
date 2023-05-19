import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_app/features/destination/models/province_model.dart';
import 'package:tourist_app/features/map/controllers/map_ctrl.dart';
import 'package:tourist_app/features/map/models/address_request.dart';
import 'package:tourist_app/features/map/models/api_map_model.dart';
import 'package:tourist_app/features/weather/models/base_request_list_model.dart';

import '../../../base/models/base_response_list.dart';
import '../../../features/weather/utils/extension.dart';

class MapCtrlImp extends MapCtrl {
  @override
  void onInit() {
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
        AddressRequest addressRequest = AddressRequest(
          idProvince: idProvince,
          detailAddress: address,
        );
        var response = await addressRepository.createAddress(addressRequest);
        if (response.restStatus == "SUCCESS") {
          Get.back();
          destinationDetailManagementCtrl.addressController.text =
              address.toString();
          destinationDetailManagementCtrl.idAddress.value =
              response.data?.id ?? 0;
        }
      }
      hideLoadingSubmit();
    }
  }
}
