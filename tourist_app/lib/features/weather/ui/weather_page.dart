import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/cores/utils/widget/base_widget/card_items.dart';
import 'package:tourist_app/cores/utils/widget/const_widget.dart';
import 'package:tourist_app/cores/utils/widget/utils_widget.dart';
import 'package:tourist_app/cores/values/dimens.dart';
import 'package:tourist_app/cores/values/font_asset.dart';
import 'package:tourist_app/cores/values/strings.dart';
import 'package:tourist_app/features/weather/controllers/weather_ctrl.dart';
import 'package:tourist_app/features/weather/controllers/weather_ctrl_imp.dart';
import 'package:tourist_app/features/weather/models/weather_response_list_model.dart';
import 'package:tourist_app/features/weather/models/weather_response_model.dart';
import 'package:tourist_app/features/weather/utils/extension.dart';
// import 'package:tourist_app/features/weather/ui/sync_chart/sync_chart.dart';

import '../../../cores/utils/widget/base_widget/key_board.dart';
import '../../../cores/utils/widget/base_widget/page.dart';
import '../../../cores/utils/widget/utils_button.dart';
import '../../../cores/values/image_asset.dart';
import '../../destination/models/province_model.dart';
import 'char_single.dart';
part 'weather_widget.dart';

class WeatherPage extends BaseGetWidget<WeatherCtrl> {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  WeatherCtrl get controller => Get.put(WeatherCtrlImp());

  @override
  Widget buildWidgets() {
    return Scaffold(
      body: baseShowLoading(
        () => _buildPage(controller),
      ),
    );
  }
}
