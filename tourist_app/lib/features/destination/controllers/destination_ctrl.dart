import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tourist_app/base/controllers/base_page_search_controller.dart';
import 'package:tourist_app/features/destination/models/destination_by_province_request.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/models/province_model.dart';
import 'package:tourist_app/features/destination/repositories/destination_repository.dart';
import 'package:tourist_app/features/destination/repositories/province_repository.dart';
import 'package:tourist_app/features/weather/models/base_request_list_model.dart';

abstract class DestinationCtrl
    extends BasePageSearchController<DestinationModel> {
  ///Get list province
  final RxList<ProvinceModel> listProvinceModel = RxList<ProvinceModel>([]);
  final RxList<DestinationModel> listDestinationDisplay =
      RxList<DestinationModel>([]);
  final RxList<ProvinceModel> listProvinceModelBS = RxList<ProvinceModel>([]);
  TextEditingController textSearchProvinceController = TextEditingController();
  RxBool isClear = false.obs;
  BaseRequestListModel baseRequestListProvinceBS = BaseRequestListModel(
    keyword: "",
    page: 0,
    size: 10,
  );
  BaseRequestListModel baseRequestListProvince = BaseRequestListModel(
    keyword: "",
    page: 0,
    size: 63,
  );
  int pageNumberProvince = 0;
  RxInt currentPageScroll = 0.obs;
  Rx<int?> indexSelect = 1.obs;
  RefreshController refreshProvinceController =
      RefreshController(initialRefresh: false);
  late ProvinceRepository provinceRepository;
  late DestinationRepository destinationRepository;

  DestinationCtrl() {
    provinceRepository = ProvinceRepository(this);
    destinationRepository = DestinationRepository(this);
  }

  Future<void> getProvince({bool isRefresh = false});

  Future<void> getProvinceBS({bool isRefresh = false});

  ///For province

  Future<void> onLoadMoreProvince();

  Future<void> onRefreshProvince();

  Future<void> functionSearchProvince();

  ///For destination in main display

  final ItemScrollController itemScrollController = ItemScrollController();
  RefreshController refreshDestinationDisplayController =
      RefreshController(initialRefresh: false);
  int pageNumberDestinationDisplay = 0;
  DestinationByProvinceRequest requestDestinationDisplay =
      DestinationByProvinceRequest(
    idProvince: 1,
    page: 0,
    size: 10,
  );

  Future<void> filterProvince(ProvinceModel item);

  Future scrollToItem(int index, ProvinceModel item);

  Future<void> onLoadMoreDestinationDisplay();

  Future<void> onRefreshDestinationDisplay();

  Future<void> getListDestinationDisplay({bool isRefresh = false});

  void goToDestinationDetail({int? id});

  ///For destination on search
  TextEditingController textSearchController = TextEditingController();
  BaseRequestListModel destinationRequest = BaseRequestListModel(
    keyword: "",
    page: 0,
    size: 15,
  );
  Future<void> getListDestination({bool isRefresh = false});

  void scheduler();
}
