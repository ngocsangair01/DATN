part of 'map_page.dart';

Widget _buildBody(MapCtrl controller) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: AppColors.baseColorGreen,
      title: Text('Map Page'),
    ),
    body: Stack(
      children: [
        Obx(
          () => GoogleMap(
            onTap: (latlng) {
              controller.selectedMarker(latlng);
            },
            onMapCreated: controller.onMapCreated,
            onCameraMove: (position) {},
            markers: controller.markers.value,
            initialCameraPosition: const CameraPosition(
              target:
                  LatLng(21.0277644, 105.8341598), // Ví dụ tọa độ San Francisco
              zoom: 12.0,
            ),
            polylines: Set<Polyline>.of(controller.polylines.value.values),
          ),
        ),
        Obx(
          () => Positioned(
            top: 20.0,
            left: 10.0,
            child: _buildRouteInfo(
                controller.duration.value, controller.distance.value),
          ),
        ),
        Visibility(
          visible: controller.startLatDisplay == null,
          child: Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter a location',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          controller.searchLocations();
                        },
                      ),
                    ),
                    onChanged: (value) {
                      controller.searchQuery = value;
                    },
                  ),
                ),
                // InkWell(
                //   onTap: () async {
                //     await controller.getLocationInfo();
                //   },
                //   child: Container(
                //     width: 50,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       color: AppColors.baseColorGreen,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: const Icon(
                //       Icons.location_on_outlined,
                //       color: Colors.white,
                //     ),
                //   ).paddingOnly(
                //     left: AppDimen.paddingVerySmall,
                //   ),
                // ),
                LoadingButton2<MapCtrl>(
                  controller,
                  title: "",
                  func: controller.getLocationInfo,
                  width: 50,
                  icon: Icons.location_on_outlined,
                ).paddingOnly(
                  left: AppDimen.paddingVerySmall,
                  top: AppDimen.paddingVerySmall,
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: controller.startLatDisplay == null,
          child: Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: LoadingButton<MapCtrl>(
              controller,
              title: "Done",
              func: controller.showSelectedMarker,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRouteInfo(int duration, int distance) {
  String durationText = '${(duration / 60).toStringAsFixed(0)} phút';
  String distanceText = '${(distance / 1000).toStringAsFixed(1)} km';

  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.timer,
          color: AppColors.baseColorGreen,
        ),
        const SizedBox(width: 4.0),
        Text(durationText),
        const SizedBox(width: 16.0),
        const Icon(
          Icons.directions,
          color: AppColors.baseColorGreen,
        ),
        const SizedBox(width: 4.0),
        Text(distanceText),
      ],
    ),
  );
}
