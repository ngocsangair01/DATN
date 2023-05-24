import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_app/base/models/base_response.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/key_board.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/models/destination_request.dart';
import 'package:tourist_app/features/destination_detail_management/controllers/destination_detail_management_ctrl.dart';

import '../values/destination_detail_management_values.dart';

class DestinationDetailManagementCtrlImp
    extends DestinationDetailManagementCtrl {
  @override
  Future<void> onInit() async {
    showLoading();
    await getDataDestination();
    hideLoading();
    super.onInit();
  }

  @override
  Future<void> getDataDestination() async {
    if (Get.arguments != null) {
      if (Get.arguments is int) {
        await getDestinationDetail(Get.arguments);
      }
    }
  }

  Future<void> getDestinationDetail(int id) async {
    var res = await destinationRepository.getDetailDestination(id);
    if (res.data != null) {
      destinationModel = res.data!;
      isCreate.value = false;
      nameController.text = destinationModel?.name ?? "";
      descriptionController.text = destinationModel?.description ?? "";
      itemType.value = DestinationValue.mapTypeDestination.entries
          .firstWhere(
              (element) => element.key == destinationModel?.destinationType?.id)
          .key;
      addressController.text = destinationModel?.address?.detailAddress ?? "";
      if (destinationModel!.images.isNotEmpty) {
        for (var i = 0; i < destinationModel!.images.length; i++) {
          XFile image = await getImageXFileByUrl(destinationModel!.images[i]);
          listImage.add(image);
        }
      }
    }
  }

  static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    XFile result = XFile(file.path);
    return result;
  }

  @override
  Future<void> createAndChangeDestination() async {
    KeyBoard.hide;
    if (formKey.currentState!.validate()) {
      try {
        showLoadingSubmit();
        final destination = destinationRequestCreate();
        if (isCreate.value) {
          await createDestination(destination);
        }
      } finally {
        hideLoadingSubmit();
      }
    }
  }

  Future<void> createDestination(DestinationRequest destinationRequest) async {
    if (destinationRequest.images.length < 3) {
      showSnackBar("you must post at least 3 photos", isSuccess: false);
    } else {
      BaseResponse<DestinationModel> response =
          await destinationRepository.createDestination(destinationRequest);
      if (response.restStatus != "SUCCESS") {
        showSnackBar(response.reasons.first, isSuccess: false);
      } else {
        Get.back(result: "SUCCESS");
        destinationManagementCtrl.getListDestinationByUser(isRefresh: true);
      }
      KeyBoard.hide();
    }
  }

  DestinationRequest destinationRequestCreate() {
    return DestinationRequest(
      id: destinationRequest?.id,
      idAddress: idAddress.value,
      description: descriptionController.text,
      name: nameController.text,
      idDestinationType: DestinationValue.mapTypeDestination.keys
          .toList()[itemType.value! - 1],
      images: listImage.map((element) => File(element!.path)).toList(),
    );
  }

  @override
  void deleteDestination() {}

  @override
  Future<void> pickMultiImage(ImageSource source) async {
    final List<XFile> pickedFileList = await picker.pickMultiImage(
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    listImage.addAll(pickedFileList);
  }
}
