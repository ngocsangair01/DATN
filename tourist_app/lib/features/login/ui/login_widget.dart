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
              child: GetBuilder<LoginCtrl>(
                builder: (controller) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HIVE_APP.get('user_name') != null
                        ? Text(
                            HIVE_USER.get('user')?.username ?? "",
                            style: const TextStyle(
                              fontFamily: FontAsset.fontLight,
                              fontSize: 20,
                            ),
                          )
                        : UtilWidget.buildInput(
                            controller.emailController,
                            borderRadius: 50,
                            height: AppDimen.heightBoxSearch,
                            isRequired: true,
                            hintText: "Username",
                            isReadOnly: HIVE_APP.get('user_name') != null,
                          ),
                    WidgetConst.sizedBoxPadding,
                    UtilWidget.buildInput(
                      controller.passwordController,
                      hintText: "Password",
                      borderRadius: 50,
                      height: AppDimen.heightBoxSearch,
                      typeInput: TypeInput.password,
                      isRequired: true,
                      isReadOnly: controller.isShowLoadingSubmit.value,
                      // isReadOnly: HIVE_APP.get('user_name') != null,
                    ),
                    WidgetConst.sizedBoxPadding,
                    SizedBox(
                      width: Get.width * AppDimen.resolutionWidgetTextEditing,
                      child: Row(
                        children: [
                          Expanded(
                            child: LoadingButton<LoginCtrl>(
                              controller,
                              title: "Login",
                              func: controller.login,
                            ),
                          ),
                          UtilWidget.sizedBox10W,
                          InkWell(
                            onTap: () {
                              controller.loginWithFingerPrint();
                            },
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: SvgPicture.asset(
                                ImageAsset.imgFingerprint,
                                color: AppColors.baseColorGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    WidgetConst.sizedBoxPadding,
                    UtilButton.buildTextButton(
                      title: 'Change account',
                      isUnderLineText: true,
                      func: () {
                        HIVE_USER.delete('user');
                        HIVE_APP.delete('user_name');
                        controller.update();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
