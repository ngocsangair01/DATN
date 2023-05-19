part of 'profile_page.dart';

Widget _buildPage() {
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
    body: SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          _buildUser(),
          _buildFirstLine(),
        ],
      ),
    ),
  );
}

Widget _buildFirstLine() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildInformation().paddingAll(
        AppDimen.paddingVerySmall,
      ),
      _buildDestination().paddingAll(
        AppDimen.paddingVerySmall,
      ),
    ],
  );
}

Widget _buildDestination() {
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

Widget _buildInformation() {
  return Container(
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
  );
}

Widget _buildUser() {
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
    ],
  );
}
