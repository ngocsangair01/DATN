import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src_controller.dart';

abstract class BasePageSearchController<T> extends BaseRefreshGetXController {
  /// List kiểu Rx: list item trong page.
  RxList<T> rxList = RxList<T>();

  /// Controller của NestscrollView.
  late ScrollController scrollController;

  /// `scrollOffset`: biến trạng thái vị trí scroll.
  RxDouble scrollOffset = 0.0.obs;

  double appBarHeight = 70.0;

  /// Controller của input search.
  TextEditingController searchController = TextEditingController();

  int pageNumber = 0;
  int totalRecords = 0;

  /// Hàm search
  Future<void> functionSearch();

  /// Kiểm tra vị trí scroll ở vị trí đầu.
  bool isScrollToTop() {
    return scrollOffset <= (appBarHeight - kToolbarHeight / 2);
  }
}
