import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourist_app/base/controllers/base_controller.dart';
import 'package:tourist_app/features/destination/models/destination_model.dart';
import 'package:tourist_app/features/destination/models/destination_request.dart';
import 'package:tourist_app/features/destination/repositories/destination_repository.dart';
import 'package:tourist_app/features/destination_management/controllers/destination_management_ctrl.dart';

abstract class DestinationDetailManagementCtrl extends BaseGetXController {
  RxList<XFile?> listImage = RxList<XFile?>();
  DestinationRequest? destinationRequest;
  DestinationModel? destinationModel;
  Rx<DestinationType?> destinationType = Rx<DestinationType?>(null);
  RxInt idAddress = 0.obs;
  Rx<int?> itemType = 1.obs;
  Rx<Address?> address = Rx<Address?>(null);
  final formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  RxBool isCreate = true.obs;
  DestinationManagementCtrl destinationManagementCtrl =
      Get.find<DestinationManagementCtrl>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  late DestinationRepository destinationRepository;
  DestinationDetailManagementCtrl() {
    if (Get.isRegistered<DestinationManagementCtrl>()) {
      destinationManagementCtrl = Get.find<DestinationManagementCtrl>();
    }
    destinationRepository = DestinationRepository(this);
  }

  Future<void> getDataDestination();

  void deleteDestination();

  void createAndChangeDestination();

  Future<void> pickMultiImage(ImageSource source);
}
