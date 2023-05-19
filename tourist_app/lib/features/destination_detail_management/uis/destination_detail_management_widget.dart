part of 'destination_detail_management_page.dart';

Widget _buildPage(DestinationDetailManagementCtrl controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar(
      'Manage your destination!',
      textStyle: const TextStyle(
        fontFamily: FontAsset.fontLight,
        fontSize: 20,
        color: Colors.black,
      ),
    ),
    body: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  UtilWidget.sizedBox10,
                  _buildImages(controller),
                  UtilWidget.sizedBox10,
                  _buildName(controller),
                  UtilWidget.sizedBox10,
                  _buildDestinationType(controller),
                  UtilWidget.sizedBox10,
                  UtilWidget.buildDividerDefault(),
                  _buildDescription(controller),
                  UtilWidget.sizedBox10,
                  UtilWidget.sizedBox10,
                  _buildAddress(controller).paddingSymmetric(
                    horizontal: AppDimen.paddingSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildButtonSubmit(controller),
      ],
    ),
  );
}

Widget _buildButtonSubmit(DestinationDetailManagementCtrl controller) {
  return LoadingButton<DestinationDetailManagementCtrl>(
        controller,
        title: "Done",
        func: controller.createAndChangeDestination,
      );
}

Widget _buildDestinationType(DestinationDetailManagementCtrl controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Destination Type",
      ).paddingAll(
        AppDimen.paddingSmall,
      ),
      Container(
        decoration: BoxDecoration(
          color: AppColors.baseColorGreen.withOpacity(0.3),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              5,
            ),
          ),
        ),
        height: AppDimen.btnMedium,
        child: Obx(
          () => Row(
            children: List.generate(
              DestinationValue.mapTypeDestination.length,
              (index) => _buildButtonFilter(
                title:
                    DestinationValue.mapTypeDestination.values.toList()[index],
                isSelect: controller.itemType.value ==
                    DestinationValue.mapTypeDestination.keys.toList()[index],
                onTap: () {
                  controller.itemType.value =
                      DestinationValue.mapTypeDestination.keys.toList()[index];
                },
              ),
            ),
          ).paddingSymmetric(
            horizontal: AppDimen.paddingSmallest,
          ),
        ),
      ).paddingOnly(
        right: AppDimen.paddingLarge,
      ),
    ],
  );
}

Widget _buildAddress(DestinationDetailManagementCtrl controller) {
  return BasicWidget.buildInputWithIcon(
    "Address",
    InputTextModel(
      controller: controller.addressController,
      hintText: "Description destination",
      isReadOnly: true,
    ),
    icon: InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.routeMapPage);
      },
      child: SizedBox(
        width: 20,
        height: 20,
        child: SvgPicture.asset(
          ImageAsset.imgDestination,
          color: AppColors.baseColorGreen,
        ).paddingSymmetric(
          horizontal: AppDimen.paddingSmall,
        ),
      ),
    ),
    isValidate: true,
  );
}

Widget _buildDescription(DestinationDetailManagementCtrl controller) {
  return BasicWidget.buildInputWithLabel(
    "Description",
    InputTextModel(
      controller: controller.descriptionController,
      hintText: "Description destination",
    ),
    isValidate: true,
  );
}

Widget _buildName(DestinationDetailManagementCtrl controller) {
  return BasicWidget.buildInputWithLabel(
    "Name",
    InputTextModel(
      controller: controller.nameController,
      hintText: "Name destination",
    ),
    isValidate: true,
  );
}

Container _buildImages(DestinationDetailManagementCtrl controller) {
  return Container(
    width: Get.width,
    height: 120,
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
    ),
    child: Row(
      children: [
        Expanded(
          child: UtilWidget.buildListScrollWithTitle(
            leading: UtilWidget.buildTitle(text: "List image"),
            itemsCount: controller.listImage.length,
            itemsWidget: (index) => _buildItemImage(index, controller),
            scrollDirection: Axis.horizontal,
            height: 75,
            isScroll: true,
            separatorWidget: WidgetConst.sizedBoxWidth10,
          ),
        ),
        InkWell(
          onTap: () {
            controller.pickMultiImage(ImageSource.gallery);
          },
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(15),
            dashPattern: const [10, 10],
            color: AppColors.baseColorGreen,
            strokeWidth: 3,
            child: SizedBox(
              child: SvgPicture.asset(
                ImageAsset.imgAddImage,
                color: AppColors.baseColorGreen,
              ).paddingAll(10),
            ),
          ).paddingAll(20),
        ).paddingOnly(
          top: AppDimen.paddingMedium,
        ),
      ],
    ),
  );
}

Widget _buildItemImage(int index, DestinationDetailManagementCtrl controller) {
  return Stack(
    children: [
      // UtilWidget.buildImageWidget(
      //   controller.listImage[index],
      //   heightImage: 75,
      //   widthImage: 95,
      //   radius: 10,
      // ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.file(
          File(controller.listImage[index]!.path),
        ),
      ),
      Positioned(
        top: double.infinity / 2,
        left: 10,
        child: Container(
          width: 30,
          height: 30,
          child: Icon(Icons.delete),
        ),
      ),
    ],
  );
}

Widget _buildButtonFilter({
  Function()? onTap,
  bool isSelect = false,
  required String title,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: isSelect ? AppColors.baseColorGreen : null,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      width: Get.width / 6,
      child: UtilWidget.buildText(
        title,
        fontWeight: isSelect ? FontWeight.bold : null,
        textColor: isSelect ? AppColors.textColorWhite : null,
      ).paddingSymmetric(
        vertical: AppDimen.paddingSmall,
        horizontal: 5,
      ),
    ),
  );
}
