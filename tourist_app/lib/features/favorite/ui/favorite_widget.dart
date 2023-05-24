part of 'favorite_page.dart';

Widget _buildFavorite(FavoriteCtrl controller) {
  controller.getListDestinationFav(isRefresh: true);
  return DefaultTabController(
    initialIndex: 0,
    length: 1,
    child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AutoSizeText(
          'Favorite',
          style: Get.textTheme.titleLarge,
        ),
        bottom: TabBar(
          indicatorColor: AppColors.backGroundColorButtonDefault,
          labelPadding:
              const EdgeInsets.symmetric(vertical: AppDimen.paddingSmall),
          tabs: [
            AutoSizeText(
              'Destinations',
              style: Get.textTheme.titleMedium,
            ),
          ],
        ),
      ),
      body: TabBarView(children: [
        Obx(
          () => _buildFavoritePage(controller),
        ),
      ]),
    ),
  );
}

Widget _buildFavoritePage(FavoriteCtrl controller) {
  return UtilWidget.buildScrollList(
    itemsCount: controller.rxList.length,
    itemWidget: (index) => CardUtils.buildCardCustomRadiusBorder(
      function: () {
        print(1);
        Get.toNamed(
          AppRoutes.routeDestinationDetail,
          arguments: controller.rxList[index].id,
        );
      },
      radiusAll: 20,
      boxShadows: BoxShadowsConst.shadowCard,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                controller
                    .deleteDestinationFav(controller.rxList[index].id ?? 0);
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: UtilWidget.itemLine(
          func: () {
            print(1);
            controller.goToDestinationDetail(id: controller.rxList[index].id);
          },
          heightImagesLeading: 70,
          widthImageLeading: 70,
          radiusImageLeading: 0,
          urlImages: controller.rxList[index].images[0],
          title: AutoSizeText(controller.rxList[index].name),
        ),
      ),
    ),
    scrollDirection: Axis.vertical,
    separatorWidget: WidgetConst.sizedBox25,
  ).paddingSymmetric(
    vertical: AppDimen.paddingSmall,
    horizontal: AppDimen.paddingLarge,
  );
}
