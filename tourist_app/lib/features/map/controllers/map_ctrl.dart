import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_app/features/destination/repositories/province_repository.dart';
import 'package:tourist_app/features/destination_detail_management/controllers/destination_detail_management_ctrl.dart';
import 'package:tourist_app/features/map/repositories/address_repository.dart';

import '../repositories/map_api_repository.dart';

abstract class MapCtrl extends BaseGetXController {
  Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  int idProvince = 0;
  String? address;
  String searchQuery = '';
  RxSet<Marker> markers = RxSet<Marker>();
  late MapApiRepository mapApiRepository;
  late ProvinceRepository provinceRepository;
  late AddressRepository addressRepository;
  late DestinationDetailManagementCtrl destinationDetailManagementCtrl;

  MapCtrl() {
    mapApiRepository = MapApiRepository(this);
    provinceRepository = ProvinceRepository(this);
    addressRepository = AddressRepository(this);
    if (Get.isRegistered<DestinationDetailManagementCtrl>()) {
      destinationDetailManagementCtrl =
          Get.find<DestinationDetailManagementCtrl>();
    }
  }
  Future<void> searchLocations();
  void selectedMarker(LatLng latLng);
  void onMapCreated(GoogleMapController controller);
  void showSelectedMarker();
}
