part of 'destination_page.dart';

Widget _buildPage(DestinationCtrl controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar(
      'Enjoy your destination!',
      isLeading: false,
      textStyle: const TextStyle(
        fontFamily: FontAsset.fontLight,
        fontSize: 20,
        color: Colors.black,
      ),
      actions: [
        UtilButton.baseOnAction(
          onTap: () {
            Get.bottomSheet(
              _buildBottomSheetDestination(controller),
              isScrollControlled: true,
            );
          },
          child: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              ImageAsset.imgSearch,
              color: Colors.black,
            ),
          ),
        ).paddingOnly(right: AppDimen.paddingSmall),
      ],
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Expanded(
                            child: ScrollablePositionedList.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemScrollController:
                                  controller.itemScrollController,
                              itemCount: controller.listProvinceModel.length,
                              itemBuilder: (context, index) =>
                                  _buildChipScroll(controller, index),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 26,
                height: 26,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      _buildBottomSheetProvince(controller),
                      isScrollControlled: true,
                    );
                  },
                  child: SvgPicture.asset(
                    ImageAsset.imgChoose,
                    color: Colors.black,
                  ),
                ),
              ).paddingOnly(left: AppDimen.paddingVerySmall),
            ],
          ),
          controller.listDestinationDisplay.isNotEmpty
              ? _buildBodyScrollVertical(controller)
              : const Center(
                  child: Text(
                    "Sorry, there is no destination here",
                  ),
                ),
        ],
      ).paddingSymmetric(horizontal: AppDimen.paddingSmall),
    ),
  );
}

Widget _buildBottomSheetDestination(DestinationCtrl controller) {
  return UtilWidget.baseBottomSheet(
    title: "Destination",
    body: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: UtilWidget.buildSearch(
                hintSearch: "Search every thing",
                borderColor: AppColors.baseColorGreen,
                textEditingController: controller.textSearchController,
                function: () {
                  controller.functionSearch();
                },
                autofocus: false,
                isClear: controller.isClear,
              ),
            ),
            UtilWidget.sizedBox10W,
            GestureDetector(
              child: Container(
                height: 40,
                width: Get.width / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                  color: AppColors.baseColorGreen,
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Radius"),
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.routeDestinationRadius);
              },
            ),
          ],
        ),
        UtilWidget.sizedBox10,
        Expanded(
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
                  return _widgetItemDestination(controller, index);
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _widgetItemDestination(DestinationCtrl controller, int index) {
  DestinationModel item = controller.rxList[index];
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(),
      ),
      // borderRadius: BorderRadius.circular(12),
    ),
    child: InkWell(
      onTap: () {
        KeyBoard.hide();
        controller.goToDestinationDetail(id: item.id);
      },
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
          ),
          width: 70,
          height: 60,
          child: Image.network(
            item.images.first,
            fit: BoxFit.cover,
          ),
        ),
        title: Text('${item.name}'),
        subtitle: Text(
          '${item.address?.detailAddress}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ),
  );
}

Column _buildBodyScrollVertical(DestinationCtrl controller) {
  return Column(
    children: [
      _buildSlideScroll(controller),
      _buildCategoryHorizontal(controller),
    ],
  );
}

Widget _buildBottomSheetProvince(DestinationCtrl controller) {
  return UtilWidget.baseBottomSheet(
    title: "List Province",
    body: Column(
      children: [
        UtilWidget.buildSearch(
          hintSearch: "Name province",
          borderColor: AppColors.baseColorGreen,
          textEditingController: controller.textSearchProvinceController,
          function: () {
            controller.functionSearchProvince();
          },
          autofocus: false,
          isClear: controller.isClear,
        ),
        UtilWidget.sizedBox10,
        Expanded(
          child: Obx(
            () => UtilWidget.buildSmartRefresher(
              refreshController: controller.refreshProvinceController,
              onRefresh: controller.onRefreshProvince,
              onLoadMore: controller.onLoadMoreProvince,
              enablePullUp: true,
              child: ListView.builder(
                itemCount: controller.listProvinceModelBS.length,
                controller: controller.scrollControllerUpToTop,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _widgetItemProvince(controller, index);
                },
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _widgetItemProvince(DestinationCtrl controller, int index) {
  ProvinceModel item = controller.listProvinceModelBS[index];
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(),
      ),
      // borderRadius: BorderRadius.circular(12),
    ),
    child: InkWell(
      onTap: () {
        KeyBoard.hide();
        controller.scrollToItem(
          index,
          item,
        );
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
        title: Text('${item.name}'),
        subtitle: Text('${item.divisionType}'),
      ),
    ),
  );
}

Widget _buildChipScroll(DestinationCtrl controller, int index) {
  return Obx(
    () => ChoiceChip(
      onSelected: (value) async {
        await controller.filterProvince(controller.listProvinceModel[index]);
      },
      disabledColor: Colors.white,
      selected: index == controller.indexSelect.value! - 1,
      labelStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.black),
      selectedColor: AppColors.baseColorGreen,
      shape: controller.indexSelect.value! - 1 == index
          ? null
          : StadiumBorder(
              side: BorderSide(
                  color: Color.fromARGB(
                      Color.getAlphaFromOpacity(0.14), 0, 0, 0))),
      label: Text(
        controller.listProvinceModel[index].name ?? "",
        style: TextStyle(
          color: controller.indexSelect.value! - 1 == index
              ? Colors.white
              : Colors.black,
        ),
      ).paddingSymmetric(
        horizontal: AppDimen.paddingSmall,
      ),
    ).paddingSymmetric(horizontal: AppDimen.paddingVerySmall),
  );
}

Widget _buildCardDetail(int index, DestinationCtrl controller) {
  return CardUtils.buildCardCustomRadiusBorder(
    boxShadows: BoxShadowsConst.shadowCard,
    radiusBottomLeft: 30,
    radiusTopRight: 30,
    child: InkWell(
      onTap: (() {
        controller.goToDestinationDetail(
          id: controller.listDestinationDisplay[index].id,
        );
      }),
      child: SizedBox(
        height: 220,
        child: CardUtils.buildContentInCard(
          heightImage: 70,
          url: controller.listDestinationDisplay[index].images[0],
          cardInfo: _buildDetailInfo(index, controller),
        ),
      ),
    ),
  );
}

Widget _buildDetailInfo(int index, DestinationCtrl controller) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.listDestinationDisplay[index].name}",
                ),
                Text(controller
                        .listDestinationDisplay[index].address?.detailAddress ??
                    ""),
              ],
            ),
          ),
          UtilWidget.buildAction(
              text: 4.7.toString(),
              iconData: Icons.star,
              spaceAround: AppDimen.paddingVerySmall,
              colorIcon: AppColors.backGroundColorButtonDefault),
        ],
      ),
      const Divider(),
      Align(
        alignment: Alignment.bottomRight,
        child: UtilButton.buildTextButton(title: "View Detail"),
      )
    ],
  );
}

Widget _buildSlideScroll(DestinationCtrl controller) {
  return UtilWidget.buildSlideTransition<DestinationCtrl>(
      heightScroll: 350,
      child: (index, controller) => _buildCardDetail(index, controller)
          .marginSymmetric(vertical: AppDimen.paddingVerySmall),
      currentIndexPosition: controller.currentPageScroll,
      itemsCount: controller.listDestinationDisplay.length,
      onPageChanged: (index) {
        controller.currentPageScroll.value = index;
      });
}

Widget _buildCategoryHorizontal(DestinationCtrl controller) {
  return UtilWidget.buildListScrollWithTitle(
    leading: UtilWidget.buildTitle(text: 'Destination'),
    itemsCount: controller.listDestinationDisplay.length,
    itemsWidget: (index) => CardUtils.buildCardCustomRadiusBorder(
        blurRadius: 20,
        spreadRadius: 0.1,
        radiusAll: 10,
        boxShadows: BoxShadowsConst.shadowCard,
        child: InkWell(
          onTap: () {
            controller.goToDestinationDetail(
                id: controller.listDestinationDisplay[index].id);
          },
          child: UtilWidget.buildCustomItemLine(
            func: () {
              controller.goToDestinationDetail(
                  id: controller.listDestinationDisplay[index].id);
            },
            trailing: UtilWidget.buildAction(
                spaceAround: AppDimen.paddingVerySmall,
                text: 4.8.toString(),
                iconData: Icons.star,
                colorIcon: AppColors.backGroundColorButtonDefault),
            spacing: 10,
            heightImage: 60,
            widthImage: 60,
            borderRadiusImage: 12,
            child: Text(controller.listDestinationDisplay[index].name ?? ""),
            urlLeading: controller.listDestinationDisplay[index].images[0],
          ).paddingSymmetric(
            vertical: AppDimen.paddingVerySmall,
            horizontal: AppDimen.paddingSmall,
          ),
        )),
    separatorWidget: WidgetConst.sizedBoxPadding,
    scrollDirection: Axis.vertical,
  );
}

Widget buttonLoading(
  Widget widget, {
  Function? function,
  bool isShowLoading = false,
}) {
  return InkWell(
    onTap: () => function?.call(),
    child: Container(
      color: AppColors.baseColorGreen,
      width: 100,
      height: 50,
      child: Row(
        children: [
          widget,
          Visibility(
            visible: isShowLoading,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.colorError,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
