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
  return SizedBox(
    width: Get.width,
    // height: 600,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              itemCount: controller.destinationOutputs?.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _buildItemItinerary(index, controller);
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

Widget _buildItemItinerary(int index, ItineraryCtrl controller) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineXY: 0.2,
    isFirst: index == 0,
    isLast: index == (controller.destinationOutputs?.length ?? 1) - 1,
    indicatorStyle: const IndicatorStyle(
      width: 20,
      color: AppColors.baseColorGreen,
      padding: EdgeInsets.all(6),
    ),
    beforeLineStyle: const LineStyle(
      color: AppColors.baseColorGreen,
      thickness: 5,
    ),
    startChild: SizedBox(
      height: 200,
      child: InkWell(
        onTap: () {
          controller.requestItineraryLatLng(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${controller.listDistance?[index]} km',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            UtilWidget.sizedBox10,
            Text('${controller.listTime?[index]} min'),
          ],
        ),
      ),
    ).paddingOnly(top: AppDimen.padding55),
    endChild: SizedBox(
      height: 200,
      child: Stack(
        children: [
          CardUtils.buildContentInCard(
            radius: 20,
            url: controller.destinationOutputs?[index].images?[0] ?? "",
            cardInfo: Text(
              controller.destinationOutputs?[index].address?.detailAddress ??
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
              '${controller.destinationOutputs?[index].name}',
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    ).paddingSymmetric(horizontal: AppDimen.paddingSmall),
  );
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
