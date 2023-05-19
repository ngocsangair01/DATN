import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/controllers/src_controller.dart';
import 'package:tourist_app/base/models/base_request_page_size.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/repositories/destination_repository.dart';

abstract class DestinationDetailCtrl extends BasePageSearchController {
  ///For destination detail
  RxString nameDestination = "".obs;
  RxString description = "".obs;
  RxInt currentPageScroll = 0.obs;
  RxBool isExpanded = false.obs;
  TextEditingController commentController = TextEditingController();
  final BaseRequestPageSize baseRequestPageSize =
      BaseRequestPageSize(page: 0, size: 10);
  late DestinationRepository destinationRepository;
  DestinationModel? destination;

  RxList<String> listImage = RxList([]);
  RxList<DestinationModel> listOther = RxList([]);
  RxList<CommentDestination> listComment = RxList([]);
  DestinationDetailCtrl() {
    destinationRepository = DestinationRepository(this);
  }

  Future<void> getDataDestination();
  Future<void> getDestinationDetail(int id);
  Future<void> getDestinationByCreateAt({bool isRefresh = false});
  Future<void> commentDestination();
}
