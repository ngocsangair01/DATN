part of 'favorite_page.dart';

Widget _buildFavorite(FavoriteCtrl controller) {
  return DefaultTabController(
    initialIndex: 0,
    length: 2,
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
            AutoSizeText(
              'Hotels',
              style: Get.textTheme.titleMedium,
            ),
          ],
        ),
      ),
      body: TabBarView(children: [
        _buildFavouritePage(),
        _buildFavouritePage(),
      ]),
    ),
  );
}

Widget _buildFavouritePage() {
  return UtilWidget.buildScrollList(
    itemsCount: 5,
    itemWidget: (index) => CardUtils.buildCardCustomRadiusBorder(
      radiusAll: 20,
      boxShadows: BoxShadowsConst.shadowCard,
      child: UtilWidget.itemLine(
        heightImagesLeading: 70,
        widthImageLeading: 70,
        radiusImageLeading: 60,
        urlImages:
            'https://cdn.pixabay.com/photo/2015/10/30/20/13/sunrise-1014712_960_720.jpg',
        title: const AutoSizeText('Ham Rong Bridge'),
      ),
    ),
    scrollDirection: Axis.vertical,
    separatorWidget: WidgetConst.sizedBox25,
  ).paddingSymmetric(
    vertical: AppDimen.paddingSmall,
    horizontal: AppDimen.padding35,
  );
}
