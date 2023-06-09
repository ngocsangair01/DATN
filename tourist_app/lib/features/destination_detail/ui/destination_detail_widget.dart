part of 'destination_detail_page.dart';

Widget _buildPageDestinationDetail(DestinationDetailCtrl controller) {
  return Scaffold(
    appBar: PageUtils.buildAppBar(
      'Destination Detail',
      backButtonColor: Colors.black,
      isLeading: true,
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
            child: Column(
              children: [
                UtilWidget.buildSlideTransition<DestinationDetailCtrl>(
                  heightScroll: 350,
                  viewportFraction: 0.5,
                  child: (index, controller) => _buildDetail(index, controller),
                  itemsCount: controller.listImage.length,
                  aspectRatio: 16 / 9,
                  currentIndexPosition: controller.currentPageScroll,
                  isUsingDotIndicator: false,
                  onPageChanged: (index) =>
                      controller.currentPageScroll.value = index,
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          controller.nameDestination.value,
                          style: const TextStyle(
                            fontFamily: FontAsset.fontLight,
                            fontSize: 20,
                          ),
                        ),
                        UtilWidget.sizedBox10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              color: AppColors.baseColorGreen,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    WidgetConst.sizedBoxPadding,
                    _buildPicture(controller),
                    WidgetConst.sizedBoxPadding,
                    _buildDescription(controller),
                    WidgetConst.sizedBoxPadding,
                    _buildButton(controller),
                    WidgetConst.sizedBoxPadding,
                    buildOtherPlace(controller),
                    WidgetConst.sizedBoxPadding,
                    _buildComment(controller),
                  ],
                ).paddingOnly(
                  left: AppDimen.paddingVerySmall,
                  bottom: AppDimen.paddingLarge,
                  right: AppDimen.paddingVerySmall,
                ),
              ],
            ),
          ),
        ),
        TextField(
          controller: controller.commentController,
          decoration: InputDecoration(
            hintText: 'Comment here',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                controller.commentDestination();
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDetail(int index, DestinationDetailCtrl controller) {
  return CardUtils.buildContentInCard(
    func: () {
      BuildContext context = Get.context!;
      var nav = Navigator.of(context);
      nav.push<void>(_createRoute(context, controller.listImage[index]));
    },
    radius: 20,
    url: controller.listImage[index],
    cardInfo: const SizedBox(),
  );
}

Widget buildOtherPlace(DestinationDetailCtrl controller) {
  return UtilWidget.buildListScrollWithTitle(
    leading: UtilWidget.buildTitle(text: 'Other place'),
    // actionWidget: UtilButton.buildTextButton(title: 'View Detail'),
    itemsCount: controller.listOther.length,
    itemsWidget: (index) => _buildItemInOtherPlace(index, controller),
    scrollDirection: Axis.horizontal,
    height: 75,
    isScroll: true,
    separatorWidget: WidgetConst.sizedBoxWidth10,
  );
}

Widget _buildItemInOtherPlace(int index, DestinationDetailCtrl controller) {
  return Stack(
    children: [
      UtilWidget.buildImageWidget(
        controller.listOther[index].images[0],
        heightImage: 75,
        widthImage: 100,
        radius: 10,
      ),
      Positioned(
        top: 45,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 75,
          ),
          color: Colors.black.withOpacity(0.4),
          child: Text(
            controller.listOther[index].name,
            style: Get.textTheme.bodyText1!
                .copyWith(color: AppColors.textColorWhite),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}

Widget _buildPicture(DestinationDetailCtrl controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      UtilWidget.buildTitle(text: "Pictures"),
      WidgetConst.sizedBoxPadding,
      SizedBox(
        width: Get.width,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: UtilWidget.buildImageWidget(
                  controller.listImage[0],
                  widthImage: double.infinity,
                  radius: 10,
                ),
              ),
              WidgetConst.sizedBoxWidth10,
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: UtilWidget.buildImageWidget(
                        controller.listImage[1],
                        widthImage: double.infinity,
                        heightImage: 100,
                        radius: 10,
                      ),
                    ),
                    WidgetConst.sizedBoxPadding,
                    Expanded(
                      child: UtilWidget.buildImageWidget(
                        controller.listImage[2],
                        widthImage: double.infinity,
                        radius: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildDescription(DestinationDetailCtrl controller) {
  return SizedBox(
    width: Get.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UtilWidget.buildTitle(text: "Description"),
        WidgetConst.sizedBoxPadding,
        Obx(
          () => Column(
            children: [
              Text(
                controller.description.value,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: FontAsset.fontLight,
                ),
                maxLines: controller.isExpanded.value ? 2 : 100,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        InkWell(
          child: Text(
            !controller.isExpanded.value ? "VIEW LESS" : "VIEW MORE",
            style: const TextStyle(
              color: AppColors.baseColorGreen,
            ),
            textAlign: TextAlign.justify,
          ),
          onTap: () {
            controller.isExpanded.toggle();
          },
        ),
      ],
    ),
  );
}

Widget _buildComment(DestinationDetailCtrl controller) {
  return UtilWidget.buildListScrollWithTitle(
    leading: UtilWidget.buildTitle(text: 'Comment'),
    itemsCount: controller.listComment.length,
    isScroll: false,
    itemsWidget: (i) {
      return Column(
        children: [
          _buildItemComment(i, controller),
        ],
      ).paddingOnly(
        left: AppDimen.padding15,
        right: AppDimen.padding15,
        top: AppDimen.paddingMedium,
      );
    },
    scrollDirection: Axis.vertical,
  );
}

Widget _buildItemComment(
  int index,
  DestinationDetailCtrl controller, {
  bool isReplyComment = false,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Icon(
        Icons.account_circle_outlined,
        size: AppDimen.sizeIcon40,
      ).paddingOnly(
        right: AppDimen.padding15,
        bottom: AppDimen.padding46,
      ),
      Expanded(
        child: CardUtils.buildCardCustomRadiusBorder(
          child: Container(
            color: AppColors.baseColorGreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      controller.listComment[index].nameUser ?? "",
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    UtilWidget.sizedBox10,
                    AutoSizeText(
                      controller.listComment[index].content ?? "",
                      style: Get.textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: AppDimen.paddingSmall),
                const Divider(
                  color: Colors.white,
                  height: 10,
                  thickness: 2,
                ),
              ],
            ).paddingOnly(
              top: AppDimen.paddingSmall,
              bottom: AppDimen.paddingSmall,
            ),
          ),
          radiusAll: 10,
        ),
      ),
    ],
  ).paddingOnly(left: isReplyComment ? AppDimen.padding25 : 0);
}

Widget _buildButton(DestinationDetailCtrl controller) {
  return InkWell(
    onTap: () async {
      await controller.addFavoriteDes(controller.idDestination ?? 0);
    },
    child: CardUtils.buildCardCustomRadiusBorder(
      radiusAll: AppDimen.radiusButtonDefault,
      boxShadows: BoxShadowsConst.shadowCard,
      child: UtilButton.buildButton(
        ButtonModel(
          btnTitle: 'INTERESTED',
          colors: [
            AppColors.baseColorGreen,
          ],
          funcHandle: () async {
            await controller.addFavoriteDes(controller.idDestination ?? 0);
          },
        ),
      ),
    ),
  );
}

Route _createRoute(BuildContext parentContext, String image) {
  return PageRouteBuilder<void>(
    pageBuilder: (context, animation, secondaryAnimation) {
      return _SecondPage(image);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var rectAnimation = _createTween(parentContext)
          .chain(CurveTween(curve: Curves.ease))
          .animate(animation);

      return Stack(
        children: [
          PositionedTransition(rect: rectAnimation, child: child),
        ],
      );
    },
  );
}

Tween<RelativeRect> _createTween(BuildContext context) {
  var windowSize = MediaQuery.of(context).size;
  var box = context.findRenderObject() as RenderBox;
  var rect = box.localToGlobal(Offset.zero) & box.size;
  var relativeRect = RelativeRect.fromSize(rect, windowSize);

  return RelativeRectTween(
    begin: relativeRect,
    end: RelativeRect.fill,
  );
}

class _SecondPage extends StatelessWidget {
  final String imageAssetName;

  const _SecondPage(this.imageAssetName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageAssetName,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
