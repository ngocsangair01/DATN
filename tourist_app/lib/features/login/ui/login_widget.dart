part of 'login_page.dart';

Widget _buildWidget(LoginCtrl controller) {
  return PageUtils.buildPageStackAppBar(
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
          color: Colors.white.withOpacity(0.7),
        ),
      ),
    ),
    body: SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "SIGN IN",
                    style: TextStyle(
                      fontFamily: FontAsset.fontLight,
                      fontSize: 32,
                    ),
                  ).paddingOnly(
                    top: Get.height / 12,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UtilWidget.buildInput(
                    controller.emailController,
                    borderRadius: 50,
                    height: AppDimen.heightBoxSearch,
                    isRequired: true,
                  ),
                  WidgetConst.sizedBoxPadding,
                  UtilWidget.buildInput(
                    controller.passwordController,
                    borderRadius: 50,
                    height: AppDimen.heightBoxSearch,
                    typeInput: TypeInput.password,
                    isRequired: true,
                  ),
                  WidgetConst.sizedBoxPadding,
                  // InkWell(
                  //   onTap: () {
                  //     controller.login();
                  //   },
                  //   child: UtilButton.buildButton(
                  //     ButtonModel(
                  //         height: AppDimen.heightBoxSearch,
                  //         btnTitle: 'SIGN IN',
                  //         textStyle: const TextStyle(
                  //           fontFamily: FontAsset.fontLight,
                  //           fontSize: 16,
                  //           color: Colors.white,
                  //         ),
                  //         borderRadius: BorderRadius.circular(50),
                  //         isShowLoading: controller.isShowLoading.value),
                  //   ),
                  // ),
                  LoadingButton<LoginCtrl>(
                    controller,
                    title: "Login",
                    func: controller.login,
                  ),
                  WidgetConst.sizedBoxPadding,
                  UtilButton.buildTextButton(
                    title: 'Forgot password',
                    isUnderLineText: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
