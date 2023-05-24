part of 'start_page.dart';

Widget _buildWidget() {
  return Container(
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
    child: Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: const Text(
                  "Explore Vietnam",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontAsset.fontBold,
                    fontSize: AppDimen.font32,
                  ),
                ).paddingOnly(
                  top: AppDimen.padding150,
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildBtn(
                      "SIGN IN",
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.routeLogin,
                        );
                      },
                      color: Colors.white,
                    ),
                    _buildBtn(
                      "SIGN UP",
                      onTap: () {
                        Get.toNamed(AppRoutes.routeSignUp);
                      },
                      color: AppColors.baseColorGreen,
                      fontColor: Colors.white,
                    ).paddingOnly(
                      top: AppDimen.paddingSmall,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.routeHome,
                        );
                      },
                      child: const Text(
                        "Skip >>",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: FontAsset.fontLight,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ).paddingOnly(
                      top: AppDimen.paddingVerySmall,
                    ),
                  ],
                ).paddingOnly(
                  top: Get.height / 10,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBtn(String content,
    {Function()? onTap, Color? color, Color? fontColor}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width / 1.3,
      height: AppDimen.heightBoxSearch,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          content,
          style: TextStyle(
            fontSize: 16,
            fontFamily: FontAsset.fontLight,
            color: fontColor,
          ),
        ),
      ),
    ),
  );
}
