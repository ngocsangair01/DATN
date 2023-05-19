import 'dart:async';

import 'package:get/get.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/features/destination/controllers/destination_ctrl.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/models/province_model.dart';
import 'package:tourist_app/routes/routes.dart';

class DestinationCtrlImp extends DestinationCtrl {
  @override
  Future<void> onInit() async {
    showLoading();
    await getProvince(isRefresh: true);
    await getProvinceBS(isRefresh: true);
    await getListDestinationDisplay(isRefresh: true);
    await getListDestination(isRefresh: true);
    hideLoading();
    scheduler();
    super.onInit();
  }

  @override
  Future<void> getListDestination({bool isRefresh = false}) async {
    destinationRequest.page = pageNumber;
    BaseResponseList<DestinationModel> res =
        await destinationRepository.getListDestination(destinationRequest);
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
  Future<void> functionSearch() async {
    destinationRequest.keyword = textSearchController.text;
    pageNumber = 0;
    await getListDestination(isRefresh: true);
  }

  @override
  Future<void> onLoadMore() async {
    pageNumber++;
    await getListDestination();
    refreshController.loadComplete();
  }

  @override
  Future<void> onRefresh() async {
    pageNumber = 0;
    rxList.clear();
    await getListDestination(isRefresh: true);
    refreshController.refreshCompleted();
  }

  @override
  Future<void> getProvince({bool isRefresh = false}) async {
    baseRequestListProvince.page = 0;
    BaseResponseList<ProvinceModel> res =
        await provinceRepository.getListProvince(baseRequestListProvince);
    if (res.restStatus == "SUCCESS") {
      List<ProvinceModel> list = res.data.toList();
      if (isRefresh) {
        listProvinceModel.assignAll(list);
      }
    } else {
      showSnackBar(res.reasons.first, isSuccess: false);
    }
  }

  @override
  Future<void> getProvinceBS({
    bool isRefresh = false,
  }) async {
    baseRequestListProvinceBS.page = pageNumberProvince;
    BaseResponseList<ProvinceModel> res =
        await provinceRepository.getListProvince(baseRequestListProvinceBS);
    if (res.restStatus == "SUCCESS") {
      List<ProvinceModel> list = res.data.toList();
      if (isRefresh) {
        listProvinceModelBS.assignAll(list);
      } else {
        listProvinceModelBS.addAll(list);
      }
    } else {
      showSnackBar(
        res.reasons.first,
        isSuccess: false,
      );
    }
  }

  @override
  Future<void> functionSearchProvince() async {
    baseRequestListProvinceBS.keyword = textSearchProvinceController.text;
    pageNumberProvince = 0;
    await getProvinceBS(isRefresh: true);
  }

  @override
  Future<void> onLoadMoreProvince() async {
    pageNumberProvince++;
    await getProvinceBS();
    refreshProvinceController.loadComplete();
  }

  @override
  Future<void> onRefreshProvince() async {
    pageNumberProvince = 0;
    listProvinceModelBS.clear();
    getProvinceBS(isRefresh: true);
    refreshProvinceController.refreshCompleted();
  }

  @override
  Future<void> getListDestinationDisplay({bool isRefresh = false}) async {
    requestDestinationDisplay.page = pageNumberDestinationDisplay;
    BaseResponseList<DestinationModel> res = await destinationRepository
        .getListDestinationByProvince(requestDestinationDisplay);
    if (res.restStatus == "SUCCESS") {
      List<DestinationModel> list = res.data.toList();
      if (isRefresh) {
        listDestinationDisplay.assignAll(list);
      }
    } else {
      showSnackBar(res.reasons.first, isSuccess: false);
    }
  }

  @override
  Future<void> onLoadMoreDestinationDisplay() async {
    pageNumberDestinationDisplay++;
    await getListDestinationDisplay();
    refreshDestinationDisplayController.loadComplete();
  }

  @override
  Future<void> onRefreshDestinationDisplay() async {
    pageNumberDestinationDisplay = 0;
    listDestinationDisplay.clear();
    getListDestinationDisplay(isRefresh: true);
    refreshDestinationDisplayController.refreshCompleted();
  }

  @override
  Future scrollToItem(int index, ProvinceModel item) async {
    await filterProvince(item);
    itemScrollController.scrollTo(
      index: indexSelect.value! - 1,
      duration: const Duration(
        seconds: 1,
      ),
    );
  }

  @override
  void goToDestinationDetail({int? id}) {
    Get.toNamed(
      AppRoutes.routeDestinationDetail,
      arguments: id,
    )?.then(
      (value) async {
        pageNumber = 0;
        pageNumberDestinationDisplay = 0;
        pageNumberProvince = 0;
        await getListDestinationDisplay(isRefresh: true);
      },
    );
  }

  @override
  Future<void> filterProvince(ProvinceModel item) async {
    indexSelect.value = item.id;
    requestDestinationDisplay.idProvince = item.id;
    await getListDestinationDisplay(isRefresh: true);
  }

  @override
  void scheduler() {
    {
      Timer.periodic(const Duration(seconds: 60), (timer) {
        getListDestination(isRefresh: true);
        getListDestinationDisplay(isRefresh: true);
      });
    }
  }
}
