part of 'information_page.dart';

Widget _buildWidget(InformationCtrl controller) {
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Information",
              style: TextStyle(
                fontFamily: FontAsset.fontLight,
                fontSize: 32,
              ),
            ),
            WidgetConst.sizedBox40,
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFirstName(controller),
                      _buildLastName(controller),
                    ],
                  ).paddingSymmetric(horizontal: 40),
                  WidgetConst.sizedBoxPadding,
                  _buildEmail(controller),
                  WidgetConst.sizedBoxPadding,
                  _buildPassword(controller),
                  WidgetConst.sizedBoxPadding,
                  _buildTelephone(controller),
                  WidgetConst.sizedBoxPadding,
                  _buildBirthday(controller).paddingOnly(
                    top: AppDimen.paddingVerySmall,
                  ),
                  WidgetConst.sizedBoxPadding,
                  _buildAddress(controller).paddingOnly(
                    top: AppDimen.paddingVerySmall,
                  ),
                  WidgetConst.sizedBoxPadding,
                  LoadingButton<InformationCtrl>(
                    controller,
                    title: "SAVE INFORMATION",
                    func: controller.changeInformation,
                  ),
                  WidgetConst.sizedBoxPadding,
                ],
              ),
            ),
          ],
        ).paddingOnly(top: AppDimen.padding55),
      ),
    ),
  );
}

Widget _buildPassword(InformationCtrl controller) {
  return UtilWidget.buildInput(
    controller.passwordController,
    borderRadius: 50,
    height: AppDimen.heightBoxSearch,
    hintText: "password",
    typeInput: TypeInput.password,
    isRequired: true,
    isReadOnly: true,
    icon: const SizedBox(
      width: 40,
      height: 40,
    ),
  );
}

Widget _buildFirstName(InformationCtrl controller) {
  return UtilWidget.buildInput(
    controller.firstNameController,
    borderRadius: 50,
    height: AppDimen.heightBoxSearch,
    hintText: "First name",
    isRequired: true,
    widthInput: 120,
  );
}

Widget _buildLastName(InformationCtrl controller) {
  return UtilWidget.buildInput(
    controller.lastNameController,
    borderRadius: 50,
    height: AppDimen.heightBoxSearch,
    isRequired: true,
    hintText: "Last name",
    widthInput: 160,
  );
}

Widget _buildEmail(InformationCtrl controller) {
  return UtilWidget.buildInput(
    controller.emailController,
    borderRadius: 50,
    hintText: "Email",
    height: AppDimen.heightBoxSearch,
    inputFormatters: InputFormatter.email,
    typeInput: TypeInput.email,
    isRequired: true,
    isReadOnly: true,
  );
}

Widget _buildBirthday(InformationCtrl controller) {
  return UtilWidget.buildInput(
    controller.birthdayController,
    borderRadius: 50,
    hintText: "Birthday: yyyy-MM-dd",
    height: AppDimen.heightBoxSearch,
    isRequired: true,
    icon: InkWell(
      onTap: () {
        controller.showDatePickerDisplay();
      },
      child: const Icon(
        Icons.calendar_month_outlined,
        color: AppColors.baseColorGreen,
      ),
    ),
  );
}

Widget _buildAddress(InformationCtrl controller) {
  return UtilWidget.buildInput(
    controller.addressController,
    borderRadius: 50,
    hintText: "Address",
    height: AppDimen.heightBoxSearch,
    isRequired: true,
    isReadOnly: true,
    icon: InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.routeMapPage)?.then(
          (value) {
            if (value != null) {
              if (value is AddressResponse) {
                controller.addressController.text =
                    value.detailAddress.toString();
                controller.idAddress = value.id;
              }
            }
          },
        );
      },
      child: SizedBox(
        width: 20,
        height: 20,
        child: SvgPicture.asset(
          ImageAsset.imgDestination,
          color: AppColors.baseColorGreen,
        ).paddingAll(13),
      ),
    ),
  );
}

Widget _buildTelephone(InformationCtrl controller) {
  return UtilWidget.buildInput(
    controller.telephoneController,
    borderRadius: 50,
    hintText: "Telephone",
    height: AppDimen.heightBoxSearch,
    typeInput: TypeInput.phoneNumber,
    inputFormatters: InputFormatter.phoneNumber,
    isRequired: true,
  );
}
