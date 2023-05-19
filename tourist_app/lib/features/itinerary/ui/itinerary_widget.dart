part of 'itinerary_page.dart';

Widget _buildPage(ItineraryCtrl controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar(
      'Itinerary',
      backButtonColor: Colors.black,
      isLeading: true,
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
            _buildAddressDetail(controller),
            UtilWidget.sizedBox10,
            _buildTravelMode(controller),
            UtilWidget.sizedBox10,
            UtilWidget.buildDivider(),
            UtilWidget.sizedBox10,
            _buildMaxDestination(controller),
            UtilWidget.sizedBox10,
            _buildButton(controller).paddingOnly(
              right: AppDimen.paddingVerySmall,
            ),
            _buildListItinerary(controller),
          ],
        ),
      ),
    ),
  );
}

Widget _buildListItinerary(ItineraryCtrl controller) {
  return Column(
    children: [
      Container(
        child: Obx(
          () => Timeline.builder(
            itemBuilder: (context, index) {
              return controller.timelineItems[index];
            },
            itemCount: controller.timelineItems.length,
            position: TimelinePosition.Center,
            shrinkWrap: true,
          ),
        ),
      ),
    ],
  ).paddingSymmetric(
      horizontal: AppDimen.defaultPadding, vertical: AppDimen.paddingSmall);
}

Widget _buildButton(ItineraryCtrl controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      LoadingButton<ItineraryCtrl>(
        controller,
        width: Get.width / 2,
        title: "Get itinerary",
        func: controller.getItinerary,
      ),
    ],
  );
}

Widget _buildAddressDetail(ItineraryCtrl controller) {
  return BasicWidget.buildInputWithLabel(
    "Address",
    InputTextModel(
      controller: controller.addressController,
      hintText: "Description destination",
      isReadOnly: true,
    ),
    isValidate: true,
  );
}

Widget _buildMaxDestination(ItineraryCtrl controller) {
  return BasicWidget.buildInputWithLabel(
    "Number of destination",
    InputTextModel(
      controller: controller.maxDestinationController,
      hintText: "Number",
      textInputType: TextInputType.number,
    ),
    isValidate: true,
  );
}

Widget _buildTravelMode(ItineraryCtrl controller) {
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
