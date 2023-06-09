import 'package:get/get.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/base/models/base_response_list.dart';
import 'package:tourist_app/cores/apps/app_controller.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/key_board.dart';
import 'package:tourist_app/features/destination/models/create_comment_destination.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination_detail/controllers/destination_detail_ctrl.dart';
import 'package:tourist_app/features/map/uis/map_page.dart';
import 'package:tourist_app/routes/pages.dart';

import '../../../cores/utils/widget/show_popup.dart';
import '../../../routes/routes.dart';
import '../../itinerary/ui/itinerary_page.dart';

class DestinationDetailCtrlImp extends DestinationDetailCtrl {
  @override
  Future<void> onInit() async {
    showLoading();
    await getDataDestination(isRefresh: true);
    await getDestinationByCreateAt(isRefresh: true);
    hideLoading();
    super.onInit();
  }

  @override
  Future<void> functionSearch() async {}

  @override
  Future<void> onLoadMore() async {}

  @override
  Future<void> onRefresh() async {}

  @override
  Future<void> getDataDestination({isRefresh = false}) async {
    if (Get.arguments != null) {
      if (Get.arguments is int) {
        if (isRefresh) {
          showLoading();
        }
        await getDestinationDetail(Get.arguments)
            .whenComplete(() => hideLoading());
      }
    }
  }

  @override
  Future<void> getDestinationDetail(int id) async {
    var res = await destinationRepository.getDetailDestination(id);
    if (res.data != null) {
      destination = res.data!;
      idDestination = destination?.id;
      nameDestination.value = destination?.name ?? "";
      description.value = destination?.description ?? "";
      listImage.value = destination?.images ?? [];
      listComment.value = destination?.commentDestinations ?? [];
    }
  }

  @override
  Future<void> getDestinationByCreateAt({bool isRefresh = false}) async {
    BaseResponseList<DestinationModel> res = await destinationRepository
        .getListDestinationByCreateAt(baseRequestPageSize)
        .whenComplete(() => hideLoading());
    if (res.restStatus == "SUCCESS") {
      List<DestinationModel> list = res.data.toList();
      if (isRefresh) {
        listOther.assignAll(list);
      }
    } else {
      showSnackBar(res.reasons.first, isSuccess: false);
    }
  }

  @override
  Future<void> commentDestination() async {
    if (HIVE_APP.get('user_name') != null) {
      if (commentController.text.isNotEmpty) {
        final comment = CreateCommentDestination(
          content: commentController.text,
          idDestination: Get.arguments,
          rating: 0,
        );
        BaseResponse baseResponse =
            await destinationRepository.createCommentDestination(comment);
        if (baseResponse.restStatus != "SUCCESS") {
          showSnackBar(baseResponse.reasons.first, isSuccess: false);
        } else {
          showSnackBar("Comment Success", isSuccess: true);
          await getDataDestination();
          commentController.clear();
          KeyBoard.hide();
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
  Future<void> addFavoriteDes(int id) async {
    if (HIVE_APP.get('user_name') != null) {
      BaseResponse<DestinationModel> response =
          await destinationRepository.addFavoriteDestination(id);
      if (response.restStatus != "SUCCESS") {
        showSnackBar(response.reasons.first, isSuccess: false);

        Get.to(ItineraryPage(
          address: destination?.address?.detailAddress,
        ));
      } else {
        showSnackBar("Added to favorite destination");

        Get.to(ItineraryPage(
          address: destination?.address?.detailAddress,
        ));
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
}
