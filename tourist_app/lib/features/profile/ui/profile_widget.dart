part of 'profile_page.dart';

Widget _buildPage(ProfileCtrl controller) {
  return PageUtils.buildPageStackAppBar(
    positionTop: 90,
    appBar: SafeArea(
      child: SizedBox(
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Profile",
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontAsset.fontLight,
                color: Colors.white,
              ),
            ).paddingOnly(left: AppDimen.paddingMedium),
          ],
        ),
      ),
    ),
    background: Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageAsset.imgBackground,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
        ),
      ),
    ),
    body: HIVE_APP.get('user_name') != null
        ? SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              children: [
                _buildUser(controller),
                _buildFirstLine(controller),
              ],
            ),
          )
        : Center(
            child: _buildButton(controller),
          ),
  );
}

Widget _buildFirstLine(ProfileCtrl controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildInformation(controller).paddingAll(
        AppDimen.paddingVerySmall,
      ),
      _buildDestination(controller).paddingAll(
        AppDimen.paddingVerySmall,
      ),
    ],
  );
}

Widget _buildDestination(ProfileCtrl controller) {
  return InkWell(
    onTap: () {
      Get.toNamed(AppRoutes.routeDestinationManagement);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: Get.width / 2.2,
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColors.baseColorGreen,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            width: 26,
            height: 26,
            child: SvgPicture.asset(
              ImageAsset.imgDestination,
              color: AppColors.baseColorGreen,
            ).paddingAll(3),
          ).paddingOnly(top: AppDimen.paddingVerySmall),
          const Text(
            "Destination",
            style: TextStyle(fontSize: 16, fontFamily: FontAsset.fontBold),
          ).paddingOnly(bottom: AppDimen.paddingVerySmall),
        ],
      ).paddingOnly(left: AppDimen.paddingVerySmall),
    ),
  );
}

Widget _buildInformation(ProfileCtrl controller) {
  return InkWell(
    onTap: () {
      Get.toNamed(AppRoutes.routeInformation);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: Get.width / 2.2,
      height: 70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColors.baseColorGreen,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            width: 26,
            height: 26,
            child: SvgPicture.asset(
              ImageAsset.imgUser,
              color: AppColors.baseColorGreen,
            ).paddingAll(3),
          ).paddingOnly(top: AppDimen.paddingVerySmall),
          const Text(
            "Information",
            style: TextStyle(fontSize: 16, fontFamily: FontAsset.fontBold),
          ).paddingOnly(bottom: AppDimen.paddingVerySmall),
        ],
      ).paddingOnly(left: AppDimen.paddingVerySmall),
    ),
  );
}

Widget _buildUser(ProfileCtrl controller) {
  return Row(
    children: [
      SizedBox(
        width: 90,
        height: 90,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: AppColors.baseColorGreen,
            ),
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          child: Center(
            child: SvgPicture.asset(
              ImageAsset.imgUser,
              color: AppColors.baseColorGreen,
            ).paddingAll(AppDimen.paddingVerySmall),
          ),
        ).paddingAll(AppDimen.paddingMedium),
      ),
      Text(
        '${HIVE_USER.get('user')?.username}',
        style: const TextStyle(
          fontFamily: FontAsset.fontBold,
          fontSize: 20,
          color: Colors.white,
        ),
      ).paddingOnly(left: AppDimen.paddingSmall),
      Expanded(
        child: InkWell(
          onTap: () async {
            await controller.logout();
          },
          child: SvgPicture.asset(
            ImageAsset.imgLogout,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

Widget _buildButton(ProfileCtrl controller) {
  return InkWell(
    onTap: () {
      Get.toNamed(AppRoutes.routeLogin);
    },
    child: CardUtils.buildCardCustomRadiusBorder(
      radiusAll: AppDimen.radiusButtonDefault,
      boxShadows: BoxShadowsConst.shadowCard,
      child: UtilButton.buildButton(
        ButtonModel(
          btnTitle: 'LOG IN',
          colors: [
            AppColors.baseColorGreen,
          ],
          funcHandle: () async {
            Get.toNamed(AppRoutes.routeLogin);
          },
        ),
      ),
    ),
  );
}
