import 'package:get/get.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/key_board.dart';
import 'package:tourist_app/features/destination/models/destination_radius_response.dart';
import 'package:tourist_app/features/destination_radius/controllers/destination_radius_ctrl.dart';
import 'package:tourist_app/routes/routes.dart';

import '../../../cores/utils/widget/show_popup.dart';
import '../../map/models/display_itinenary_request.dart';
import '../../map/uis/map_page.dart';

class DestinationRadiusCtrlImp extends DestinationRadiusCtrl {
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
  Future<void> searchDestination() async {
    KeyBoard.hide();
    if (HIVE_APP.get("user_name") != null) {
      if (formKey.currentState!.validate()) {
        try {
          showLoadingSubmit();
          destinationRadiusRequest
            ..keyword = addressController.text
            ..radius = double.parse(radiusController.text)
            ..page = 0
            ..size = 10;
          var response = await destinationRepository
              .getListDestinationRadius(destinationRadiusRequest);
          if (response.restStatus == "SUCCESS") {
            if (response.data != null) {
              DestinationRadiusResponse destinationRadiusResponse =
                  response.data!;
              listDestinationDataOutput.value =
                  destinationRadiusResponse.listDestinationDataOutput ?? [];
              if (listDestinationDataOutput.isEmpty) {
                showSnackBar(
                    "Sorry, there is no destination around here,Please search more broadly");
              }
              listDistance.value = destinationRadiusResponse.listDistance ?? [];
            }
          }
        } finally {
          hideLoadingSubmit();
        }
      }
    } else {
      ShowPopup.showDialogConfirm(
        "You need to be logged in to perform this function ",
        actionTitle: 'Accept',
        confirm: () async {
          Get.toNamed(
            AppRoutes.routeLogin,
          );
        },
      );
    }
  }

  @override
  void requestItineraryLatLng(int index) {
    DisplayItineraryRequest request = DisplayItineraryRequest(
      startLat: latOrigin,
      startLng: lngOrigin,
      endLat: listDestinationDataOutput[index].address?.latitude,
      endLng: listDestinationDataOutput[index].address?.longitude,
      travelMode: travelMode.value,
    );
    Get.to(
      MapPage(
        displayItineraryRequest: request,
      ),
    );
  }
}
