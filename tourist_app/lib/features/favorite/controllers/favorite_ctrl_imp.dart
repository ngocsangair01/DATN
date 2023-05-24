import 'package:get/get.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/favorite/controllers/favorite_ctrl.dart';

import '../../../routes/routes.dart';

class FavoriteCtrlImp extends FavoriteCtrl {
  @override
  Future<void> onInit() async {
    await getListDestinationFav(isRefresh: true);
    super.onInit();
  }

  @override
  Future<void> functionSearch() async {}

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {}

  @override
  Future<void> getListDestinationFav({bool isRefresh = false}) async {
    BaseResponseList<DestinationModel> res =
        await destinationRepository.viewFavoriteDestination();
    if (res.restStatus == "SUCCESS") {
      List<DestinationModel> list = res.data.toList();
      if (isRefresh) {
        rxList.assignAll(list);
      } else {
        rxList.addAll(list);
      }
    } else {
      showSnackBar(
        res.reasons.first,
        isSuccess: false,
      );
    }
  }

  @override
  Future<void> deleteDestinationFav(int id) async {
    BaseResponse<DestinationModel> res =
        await destinationRepository.deleteFavoriteDestination(id);
    if (res.restStatus == "SUCCESS") {
      showSnackBar(
        res.message ?? "",
        isSuccess: true,
      );
      await getListDestinationFav(isRefresh: true);
    } else {
      showSnackBar(
        res.reasons.first,
        isSuccess: false,
      );
    }
  }

  @override
  void goToDestinationDetail({int? id}) {
    Get.toNamed(
      AppRoutes.routeDestinationDetail,
      arguments: id,
    );
  }
}
