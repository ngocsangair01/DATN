part of 'destination_management_page.dart';

Widget _buildPageDestinationManager(DestinationManagementCtrl controller) {
  return DefaultTabController(
    initialIndex: 0,
    length: 1,
    child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.gotoDestinationDetail();
        },
        backgroundColor: AppColors.baseColorGreen,
        splashColor: AppColors.baseColorPurple,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              ImageAsset.imgBack,
              color: Colors.black,
            ).paddingAll(AppDimen.paddingSmallest),
          ),
        ),
        title: AutoSizeText(
          'My Destination',
          style: Get.textTheme.titleLarge,
        ),
        bottom: TabBar(
          indicatorColor: AppColors.backGroundColorButtonDefault,
          tabs: [
            Visibility(
              visible: true,
              child: UtilWidget.buildSearch(
                height: 50,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                hintSearch: "Search your destination",
                borderColor: AppColors.baseColorGreen,
                textEditingController: controller.textSearchController,
                function: () {
                  controller
                      .searchDestination(controller.textSearchController.text);
                },
                autofocus: false,
                isClear: controller.isClear,
              ),
            ),
          ],
        ),
      ),
      body: _buildListDestination(controller),
    ),
  );
}

Widget _buildListDestination(DestinationManagementCtrl controller) {
  return Column(
    children: [
      Expanded(
        child: Obx(
          () => UtilWidget.buildSmartRefresher(
            refreshController: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoadMore: controller.onLoadMore,
            enablePullUp: true,
            child: ListView.builder(
              itemCount: controller.listDestination.length,
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
  );
}

Widget _widgetItemDestination(DestinationManagementCtrl controller, int index) {
  DestinationModel item = controller.listDestination[index];
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
        controller.gotoDestinationDetail(id: item.id);
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
