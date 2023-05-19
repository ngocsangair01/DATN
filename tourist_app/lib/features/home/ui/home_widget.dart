part of 'home_page.dart';

Widget _buildNotchBottomBar(HomeCtrl controller) {
  return AnimatedNotchBottomBar(
    pageController: controller.pageController,
    color: Colors.white,
    showLabel: false,
    notchColor: AppColors.baseColorGreen,
    bottomBarItems: [
      BottomBarItem(
        inActiveItem: SvgPicture.asset(
          ImageAsset.imgDestination,
          color: Colors.blueGrey,
        ),
        activeItem: SvgPicture.asset(
          ImageAsset.imgDestination,
          color: Colors.white,
        ),
      ),
      BottomBarItem(
        inActiveItem: SvgPicture.asset(
          ImageAsset.imgFavorite,
          color: Colors.blueGrey,
        ),
        activeItem: SvgPicture.asset(
          ImageAsset.imgFavorite,
          color: Colors.white,
        ),
      ),
      BottomBarItem(
        inActiveItem: SvgPicture.asset(
          ImageAsset.imgWeather,
          color: Colors.blueGrey,
        ),
        activeItem: SvgPicture.asset(
          ImageAsset.imgWeather,
          color: Colors.white,
        ),
      ),
      BottomBarItem(
        inActiveItem: SvgPicture.asset(
          ImageAsset.imgUser,
          color: Colors.blueGrey,
        ),
        activeItem: SvgPicture.asset(
          ImageAsset.imgUser,
          color: Colors.white,
        ),
      ),
    ],
    onTap: (index) {
      controller.pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    },
  );
}

Widget _buildBody(HomeCtrl controller) {
  return PageView(
    controller: controller.pageController,
    physics: const NeverScrollableScrollPhysics(),
    children: List.generate(controller.bottomBarPages.length,
        (index) => controller.bottomBarPages[index]),
  );
}
