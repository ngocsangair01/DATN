import 'package:get/get.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination_management/controllers/destination_management_ctrl.dart';
import 'package:tourist_app/routes/routes.dart';

import '../../../cores/apps/app_controller.dart';

class DestinationManagementCtrlImp extends DestinationManagementCtrl {
  @override
  Future<void> onInit() async {
    showLoading();
    await getListDestinationByUser(isRefresh: true);
    getListDestinationSearch();
    hideLoading();
    super.onInit();
  }

  @override
  Future<void> functionSearch() async {}

  @override
  Future<void> onLoadMore() async {
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    listDestination.clear();
    await getListDestinationByUser(isRefresh: true);
    getListDestinationSearch();
    refreshController.refreshCompleted();
  }

  @override
  Future<void> getListDestinationByUser({bool isRefresh = false}) async {
    BaseResponseList<DestinationModel> res = await destinationRepository
        .getListDestinationByUser(HIVE_USER.get('user')?.userId ?? 0);
    if (isRefresh) {
      rxList.clear();
    }
    rxList.addAll(res.data);
  }

  @override
  void searchDestination(String keyword) {
    listDestination.clear();
    if (keyword.isEmpty) {
      listDestination.addAll(rxList);
    } else {
      for (int i = 0; i < rxList.length; i++) {
        if (rxList[i].name.isCaseInsensitiveContainsAny(keyword)) {
          listDestination.add(rxList[i]);
        }
      }
    }
  }

  @override
  void getListDestinationSearch() {
    listDestination.addAll(rxList);
  }

  @override
  void switchStatusBoxSearch() {
    displayBoxSearch.toggle();
  }

  @override
  void gotoDestinationDetail({int? id}) {
    Get.toNamed(
      AppRoutes.routeDestinationDetailManagement,
      arguments: id,
    )?.then((value) async {
      pageNumber = 0;
      await getListDestinationByUser(isRefresh: true);
    });
  }
}
