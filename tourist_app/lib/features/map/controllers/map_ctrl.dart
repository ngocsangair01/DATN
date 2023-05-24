import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_app/features/destination/repositories/province_repository.dart';
import 'package:tourist_app/features/destination_detail_management/controllers/destination_detail_management_ctrl.dart';
import 'package:tourist_app/features/map/repositories/address_repository.dart';

import '../models/display_itinenary_request.dart';
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
  RxMap<PolylineId, Polyline> polylines = RxMap({});
  DisplayItineraryRequest? itineraryRequestArg;
  late double? startLatDisplay;
  late double? startLngDisplay;
  late double? endLatDisplay;
  late double? endLngDisplay;
  late String? travelMode;
  RxInt duration = 0.obs;
  RxInt distance = 0.obs;
  MapCtrl({this.itineraryRequestArg}) {
    mapApiRepository = MapApiRepository(this);
    provinceRepository = ProvinceRepository(this);
    addressRepository = AddressRepository(this);
    if (Get.isRegistered<DestinationDetailManagementCtrl>()) {
      destinationDetailManagementCtrl =
          Get.find<DestinationDetailManagementCtrl>();
    }
    startLatDisplay = itineraryRequestArg?.startLat;
    startLngDisplay = itineraryRequestArg?.startLng;
    endLatDisplay = itineraryRequestArg?.endLat;
    endLngDisplay = itineraryRequestArg?.endLng;
    travelMode = itineraryRequestArg?.travelMode;
  }
  Future<void> searchLocations();
  void selectedMarker(LatLng latLng);
  void onMapCreated(GoogleMapController controller);
  void showSelectedMarker();
  Future<void> fetchRoute();
  LatLngBounds getBounds(List<LatLng> routePoints);
  Future<void> getLocationInfo();
}
