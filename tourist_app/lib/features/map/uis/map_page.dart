import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/cores/themes/colors.dart';
import 'package:tourist_app/features/map/controllers/map_ctrl.dart';
import 'package:tourist_app/features/map/controllers/map_ctrl_imp.dart';

import '../../../cores/utils/widget/loading_button.dart';

part 'map_widget.dart';

class MapPage extends BaseGetWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  MapCtrl get controller => Get.put(MapCtrlImp());

  @override
  Widget buildWidgets() {
    return _buildBody(controller);
  }
}
