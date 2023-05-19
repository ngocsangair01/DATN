import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/repositories/destination_repository.dart';

import '../../../base/controllers/src_controller.dart';

abstract class DestinationManagementCtrl
    extends BasePageSearchController<DestinationModel> {
  late DestinationRepository destinationRepository;

  TextEditingController textSearchController = TextEditingController();

  RxBool displayBoxSearch = false.obs;

  RxBool isClear = false.obs;

  RxList<DestinationModel> listDestination = RxList<DestinationModel>();

  DestinationManagementCtrl() {
    destinationRepository = DestinationRepository(this);
  }

  Future<void> getListDestinationByUser({bool isRefresh = false});

  void searchDestination(String keyword);

  void getListDestinationSearch();

  void switchStatusBoxSearch();

  void gotoDestinationDetail({int? id});
}
