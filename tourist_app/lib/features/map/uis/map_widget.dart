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
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          right: 10,
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
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          // child: ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all(
          //       AppColors.baseColorGreen,
          //     ),
          //   ),
          //   child: Text('Submit'),
          //   onPressed: () {
          //     controller.showSelectedMarker();
          //   },
          // ),
          child: LoadingButton<MapCtrl>(
            controller,
            title: "Done",
            func: controller.showSelectedMarker,
          ),
        ),
      ],
    ),
  );
}
