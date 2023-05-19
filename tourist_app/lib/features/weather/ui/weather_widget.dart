part of 'weather_page.dart';

Widget _buildPage(WeatherCtrl controller) {
  return PageUtils.buildPageStackAppBar(
    positionTop: 90,
    appBar: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Text(
                  controller.nameProvince.value,
                  style: TextStyle(
                    fontFamily: FontAsset.fontBold,
                    color: controller.textColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  controller.dateTimeFormat.value,
                  style: TextStyle(
                    fontFamily: FontAsset.fontRegular,
                    color: controller.textColor,
                    fontSize: 10,
                  ),
                ).paddingOnly(
                  top: AppDimen.paddingSmallest,
                ),
              ],
            ),
          ),
          Expanded(
            child: UtilButton.baseOnAction(
              onTap: () {
                Get.bottomSheet(
                  UtilWidget.baseBottomSheet(
                    title: "Weather",
                    backgroundColor: Colors.black.withOpacity(0.7),
                    body: Column(
                      children: [
                        UtilWidget.buildSearch(
                          textColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          hintSearch: "Name province",
                          hintColor: Colors.white,
                          borderColor: AppColors.baseColorGreen,
                          textEditingController:
                              controller.textSearchProvinceController,
                          function: () {
                            controller.functionSearch();
                          },
                          autofocus: false,
                          isClear: controller.isClear,
                        ),
                        UtilWidget.sizedBox10,
                        _buildListProvince(controller),
                      ],
                    ),
                  ),
                  isScrollControlled: true,
                );
              },
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  ImageAsset.imgSearch,
                  color: controller.textColor,
                ),
              ),
            ).paddingOnly(right: AppDimen.paddingSmall),
          ),
        ],
      ),
    ),
    background: Obx(
      () => Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 1,
            image: AssetImage(
              controller.background.value,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _currentWeather(controller),
          _buildWeatherDetail(controller),
          _buildWeatherEveryDay(controller),
        ],
      ).paddingSymmetric(
        horizontal: AppDimen.paddingSmall,
      ),
    ).paddingOnly(top: AppDimen.paddingHuge),
  );
}

Expanded _buildListProvince(WeatherCtrl controller) {
  return Expanded(
    child: Obx(
      () => UtilWidget.buildSmartRefresher(
        refreshController: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoadMore: controller.onLoadMore,
        enablePullUp: true,
        child: ListView.builder(
          itemCount: controller.rxList.length,
          controller: controller.scrollControllerUpToTop,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return _widgetItemProvince(controller, index);
          },
        ),
      ),
    ),
  );
}

Widget _widgetItemProvince(WeatherCtrl controller, int index) {
  WeatherResponseListModel item = controller.rxList[index];
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.white),
      ),
      // borderRadius: BorderRadius.circular(12),
    ),
    child: InkWell(
      onTap: () async {
        KeyBoard.hide();
        await controller.getWeatherById(id: item.idProvince);
        Get.back();
      },
      child: ListTile(
        leading: SizedBox(
          width: 20,
          height: 20,
          child: SvgPicture.asset(
            ImageAsset.imgProvince,
            color: AppColors.baseColorGreen,
          ),
        ).paddingOnly(top: AppDimen.paddingSmall),
        title: Text(
          '${item.province}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          '${item.temp}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: SizedBox(
          width: 30,
          height: 30,
          child: item.icon,
        ),
      ),
    ),
  );
}

Widget _buildWeatherDetail(WeatherCtrl controller) {
  return CardUtils.buildCardCustomRadiusBorder(
    radiusAll: 20,
    backgroundColor: Colors.black.withOpacity(0.7),
    child: Column(
      children: [
        _buildHeaderWidgetDetail(),
        const Divider(color: Colors.white),
        _buildBodyWidgetDetail(controller),
      ],
    ),
  ).paddingSymmetric(vertical: AppDimen.paddingVerySmall);
}

Widget _buildHeaderWidgetDetail() {
  return Row(
    children: [
      AutoSizeText(
        AppStr.focus24h,
        style: Get.textTheme.bodyText1!.copyWith(
          color: Colors.white,
        ),
      ).paddingOnly(
        left: AppDimen.paddingVerySmall,
        top: AppDimen.paddingVerySmall,
      ),
      const Spacer(),
      // AutoSizeText(
      //   AppStr.threeDayHours,
      //   style: Get.textTheme.bodyText1!.copyWith(
      //     color: Colors.white,
      //   ),
      // ),
      // WidgetConst.sizedBoxWidth10,
      // const Icon(
      //   Icons.arrow_forward_ios,
      //   color: Colors.white,
      //   size: 14,
      // )
    ],
  ).paddingSymmetric(
    horizontal: AppDimen.paddingVerySmall,
    vertical: AppDimen.paddingSmall,
  );
}

Widget _buildBodyWidgetDetail(WeatherCtrl controller) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
            controller.weatherNow.length,
            (index) => Column(
                  children: [
                    AutoSizeText(
                      DateFormat.Hm().format(
                          controller.weatherNow[index].dateTime ??
                              DateTime.now()),
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontSize: 12, color: Colors.white),
                    ),
                    WidgetConst.sizedBox10,
                    const Icon(
                      Icons.cloud,
                      color: Color.fromRGBO(96, 183, 252, 1),
                    )
                  ],
                )),
      ),
      WidgetConst.sizedBox10,
      WeatherChart2(
        currentWeather: controller.weatherNow,
      ),
    ],
  ).paddingSymmetric(
      horizontal: AppDimen.defaultPadding, vertical: AppDimen.paddingSmall);
}

Widget _buildWeatherEveryDay(WeatherCtrl controller) {
  return CardUtils.buildCardCustomRadiusBorder(
    radiusAll: 20,
    backgroundColor: Colors.black.withOpacity(0.7),
    child: Column(
      children: [
        _buildHeaderWidgetDetail(),
        const Divider(
          color: Colors.white,
          thickness: 1,
        ),
        UtilWidget.buildScrollList(
          isScroll: false,
          separatorWidget: WidgetConst.sizedBox25,
          itemsCount: controller.weatherOfDays.length,
          itemWidget: (index) => _buildItemInWeatherNow(
            controller.weatherOfDays[index],
          ),
        )
      ],
    ).paddingSymmetric(vertical: AppDimen.paddingVerySmall),
  ).paddingSymmetric(vertical: AppDimen.paddingVerySmall);
}

Widget _buildItemInWeatherNow(CurrentWeather currentWeather) {
  return UtilWidget.buildCustomItemLine(
      leading: SizedBox(
        width: Get.width / 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              (currentWeather.dateTime ?? DateTime.now()).dateString,
              style: AppColors.textStyleWhite,
            ),
            AutoSizeText(
              DateFormat.Md().format(
                currentWeather.dateTime ?? DateTime.now(),
              ),
              style: AppColors.textStyleWhite,
            ),
          ],
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.cloud,
            color: Colors.white,
          ),
          WidgetConst.sizedBoxWidth30,
          AutoSizeText(
            currentWeather.description ?? '',
            style: AppColors.textStyleWhite,
          ),
        ],
      ).paddingSymmetric(horizontal: AppDimen.paddingSmall),
      trailing: Row(
        children: [
          AutoSizeText(
            currentWeather.tempMin.formatTemp(),
            style: Get.textTheme.bodyText1!
                .copyWith(color: const Color.fromRGBO(73, 204, 247, 1)),
          ),
          WidgetConst.sizedBoxWidth10,
          AutoSizeText(currentWeather.tempMax.formatTemp(),
              style: Get.textTheme.bodyText1!
                  .copyWith(color: const Color.fromRGBO(217, 122, 84, 1))),
        ],
      )).paddingSymmetric(horizontal: AppDimen.paddingSmall);
}

Widget _currentWeather(WeatherCtrl controller) {
  return SizedBox(
    width: Get.width,
    height: Get.height / 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          controller.currentWeather.value.description?.toUpperCase() ?? "",
          style: TextStyle(
            fontSize: 24,
            fontFamily: FontAsset.fontRegular,
            color: controller.textColor,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${controller.currentWeather.value.temp?.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 70,
                fontFamily: FontAsset.fontBold,
                color: controller.textColor,
              ),
            ),
            Text(
              "°C",
              style: TextStyle(
                fontSize: 64,
                fontFamily: FontAsset.fontBold,
                color: controller.textColor,
              ),
            ).paddingOnly(
              top: AppDimen.paddingSmallest,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temp:',
              style: TextStyle(
                fontFamily: FontAsset.fontRegular,
                fontSize: 16,
                color: controller.textColor,
              ),
            ),
            Text(
              'Max:${controller.currentWeather.value.tempMax?.toStringAsFixed(0)}°  Min:${controller.currentWeather.value.tempMin?.toStringAsFixed(0)}°',
              style: TextStyle(
                fontFamily: FontAsset.fontRegular,
                fontSize: 16,
                color: controller.textColor,
              ),
            ).paddingOnly(
              left: AppDimen.paddingMedium,
            ),
          ],
        ),
        Text(
          'Humidity: ${controller.currentWeather.value.humidity}%',
          style: TextStyle(
            fontFamily: FontAsset.fontRegular,
            fontSize: 16,
            color: controller.textColor,
          ),
        ),
      ],
    ),
  );
}
