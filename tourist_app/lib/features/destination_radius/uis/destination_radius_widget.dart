part of 'destination_radius_page.dart';

Widget _buildPage(DestinationRadiusCtrl controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar(
      'Find your destination!',
      textStyle: const TextStyle(
        fontFamily: FontAsset.fontLight,
        fontSize: 20,
        color: Colors.black,
      ),
    ),
    body: SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            _buildAddress(controller).paddingSymmetric(
              horizontal: AppDimen.paddingVerySmall,
            ),
            UtilWidget.sizedBox10,
            _buildTravelMode(controller),
            UtilWidget.sizedBox10,
            UtilWidget.buildDivider(),
            _buildRadius(controller),
            UtilWidget.sizedBox10,
            _buildButton(controller),
            _buildListDestination(controller),
          ],
        ),
      ),
    ),
  );
}

Widget _buildListDestination(DestinationRadiusCtrl controller) {
  return SizedBox(
    width: Get.width,
    // height: 600,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.listDestinationDataOutput.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildItemDestination(index, controller);
              },
            ),
          ),
        ],
      ).paddingSymmetric(
        horizontal: AppDimen.defaultPadding,
        vertical: AppDimen.paddingSmall,
      ),
    ),
  );
}

Widget _buildItemDestination(int index, DestinationRadiusCtrl controller) {
  return Column(
    children: [
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.4,
        isFirst: index == 0,
        isLast: index == (controller.listDestinationDataOutput.length ?? 1) - 1,
        indicatorStyle: const IndicatorStyle(
          width: 20,
          color: Colors.green,
          padding: EdgeInsets.all(6),
        ),
        beforeLineStyle: const LineStyle(
          color: Colors.green,
          thickness: 2,
        ),
        afterLineStyle: const LineStyle(
          color: Colors.green,
          thickness: 2,
        ),
        startChild: InkWell(
          onTap: () {
            controller.requestItineraryLatLng(index);
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.listDestinationDataOutput[index].name.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${controller.listDistance[index]} km",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        endChild: SizedBox(
          height: 200,
          child: Stack(
            children: [
              CardUtils.buildContentInCard(
                radius: 20,
                url: controller.listDestinationDataOutput[index].images?[0] ??
                    "",
                cardInfo: Text(
                  controller.listDestinationDataOutput[index].address
                          ?.detailAddress ??
                      "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 5,
                child: Text(
                  '${controller.listDestinationDataOutput[index].name}',
                  style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildRadius(DestinationRadiusCtrl controller) {
  return BasicWidget.buildInputWithLabel(
    "Radius",
    InputTextModel(
      controller: controller.radiusController,
      hintText: "Example: 2",
    ),
    isValidate: true,
  );
}

Widget _buildAddress(DestinationRadiusCtrl controller) {
  return BasicWidget.buildInputWithIcon(
    "Address",
    InputTextModel(
      controller: controller.addressController,
      hintText: "Description destination",
      isReadOnly: true,
    ),
    icon: InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.routeMapPage)?.then(
          (value) {
            if (value != null) {
              if (value is AddressResponse) {
                controller.addressController.text =
                    value.detailAddress.toString();
                controller.latOrigin = value.latitude;
                controller.lngOrigin = value.longitude;
              }
            }
          },
        );
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

Widget _buildButton(DestinationRadiusCtrl controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      LoadingButton<DestinationRadiusCtrl>(
        controller,
        width: Get.width / 2,
        title: "Search",
        func: controller.searchDestination,
      ),
    ],
  );
}

Widget _buildTravelMode(DestinationRadiusCtrl controller) {
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
              ItineraryValue.mapTravelMode.length,
              (index) => _buildButtonFilter(
                title: ItineraryValue.mapTravelMode.values.toList()[index],
                isSelect: controller.travelMode.value ==
                    ItineraryValue.mapTravelMode.keys.toList()[index],
                onTap: () {
                  controller.travelMode.value =
                      ItineraryValue.mapTravelMode.values.toList()[index];
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
