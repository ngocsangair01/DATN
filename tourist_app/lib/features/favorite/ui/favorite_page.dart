import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/base/widgets/base_widget.dart';
import 'package:tourist_app/features/favorite/controllers/favorite_ctrl.dart';
import 'package:tourist_app/features/favorite/controllers/favorite_ctrl_imp.dart';
import '../../../cores/themes/box_shadows.dart';
import '../../../cores/themes/colors.dart';
import '../../../cores/utils/widget/base_widget/card_items.dart';
import '../../../cores/utils/widget/const_widget.dart';
import '../../../cores/utils/widget/utils_widget.dart';
import '../../../cores/values/dimens.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../routes/routes.dart';

part 'favorite_widget.dart';

class FavoritePage extends BaseGetWidget<FavoriteCtrl> {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  FavoriteCtrl get controller => Get.put(FavoriteCtrlImp());

  @override
  Widget buildWidgets() {
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: baseShowLoading(
        () => _buildFavorite(controller),
      ),
    );
  }
}
