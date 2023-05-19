/// dart import
import 'dart:math';

/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/weather_response_model.dart';

/// Local imports
/// Renders the chart with default trackball sample.
class InfiniteScrolling extends StatefulWidget {
  /// Creates the chart with default trackball sample.
  const InfiniteScrolling({Key? key, required this.currentWeather})
      : super(key: key);
  final List<CurrentWeather> currentWeather;
  @override
  _InfiniteScrollingState createState() => _InfiniteScrollingState();
}

/// State class the chart with default trackball.
class _InfiniteScrollingState extends State<InfiniteScrolling> {
  _InfiniteScrollingState();

  ChartSeriesController? seriesController;
  late List<ChartSampleData> chartData;

  late bool isLoadMoreView, isNeedToUpdateView, isDataUpdated;

  double? oldAxisVisibleMin, oldAxisVisibleMax;

  late ZoomPanBehavior _zoomPanBehavior;

  late GlobalKey<State> globalKey;
  @override
  void initState() {
    _initializeVariables();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildInfiniteScrollingChart();
  }

  void _initializeVariables() {
    chartData = widget.currentWeather
        .map((e) => ChartSampleData(
            xValue: widget.currentWeather.indexOf(e), y: e.temp!))
        .toList()
        .getRange(0, 5)
        .toList();
    isLoadMoreView = false;
    isNeedToUpdateView = false;
    isDataUpdated = true;
    globalKey = GlobalKey<State>();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
    );
  }

  /// Returns the cartesian chart with default trackball.
  SfCartesianChart _buildInfiniteScrollingChart() {
    return SfCartesianChart(
      key: GlobalKey<State>(),
      onActualRangeChanged: (ActualRangeChangedArgs args) {
        if (args.orientation == AxisOrientation.horizontal) {
          if (isLoadMoreView) {
            args.visibleMin = oldAxisVisibleMin;
            args.visibleMax = oldAxisVisibleMax;
          }
          oldAxisVisibleMin = args.visibleMin as double;
          oldAxisVisibleMax = args.visibleMax as double;
        }
        isLoadMoreView = false;
      },
      zoomPanBehavior: _zoomPanBehavior,
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
          name: 'XAxis',
          interval: 2,
          enableAutoIntervalOnZooming: false,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: const MajorGridLines(width: 0),
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            return ChartAxisLabel(details.text.split('.')[0], null);
          }),
      primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent),
          axisLabelFormatter: (AxisLabelRenderDetails details) {
            return ChartAxisLabel(details.text, null);
          }),
      series: getSeries(),
      loadMoreIndicatorBuilder:
          (BuildContext context, ChartSwipeDirection direction) =>
              getloadMoreIndicatorBuilder(context, direction),
    );
  }

  List<LineSeries<ChartSampleData, num>> getSeries() {
    return <LineSeries<ChartSampleData, num>>[
      LineSeries<ChartSampleData, num>(
        dataSource: chartData,
        color: const Color.fromRGBO(75, 135, 185, 0.6),
        xValueMapper: (ChartSampleData sales, _) => sales.xValue,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        onRendererCreated: (ChartSeriesController controller) {
          seriesController = controller;
        },
      ),
    ];
  }

  Widget getloadMoreIndicatorBuilder(
      BuildContext context, ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      isNeedToUpdateView = true;
      globalKey = GlobalKey<State>();
      return StatefulBuilder(
          key: globalKey,
          builder: (BuildContext context, StateSetter stateSetter) {
            Widget widget;
            if (isNeedToUpdateView) {
              widget = Container();
              _updateView();
              isDataUpdated = true;
            } else {
              widget = Container();
            }
            return widget;
          });
    } else {
      return SizedBox.fromSize(size: Size.zero);
    }
  }

  Widget getProgressIndicator() {
    return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 22),
            child: Container(
                width: 50,
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(33, 33, 33, 0.0),
                    Color.fromRGBO(33, 33, 33, 0.74)
                  ], stops: <double>[
                    0.0,
                    1
                  ]),
                ),
                child: const SizedBox(
                    height: 35,
                    width: 35,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      backgroundColor: Colors.transparent,
                      strokeWidth: 3,
                    )))));
  }

  void _updateData() {
    int _numbLoop = 0;
    if (widget.currentWeather.length - chartData.length >= 5) {
      _numbLoop = 5;
    } else {
      _numbLoop = widget.currentWeather.length - chartData.length;
    }
    if (_numbLoop != 0) {
      for (int i = 0; i < _numbLoop - 1; i++) {
        int _newIndex = chartData.last.xValue + 1;
        chartData.add(ChartSampleData(
            xValue: _newIndex, y: widget.currentWeather[_newIndex].temp!));
      }
      isLoadMoreView = true;
      seriesController?.updateDataSource(addedDataIndexes: getIndexes(5));
    }
  }

  Future<void> _updateView() async {
    isNeedToUpdateView = false;
    if (isDataUpdated) {
      _updateData();
      isDataUpdated = false;
    }
    if (globalKey.currentState != null) {
      (globalKey.currentState as dynamic).setState(() {});
    }
  }

  List<int> getIndexes(int length) {
    final List<int> indexes = <int>[];
    for (int i = length - 1; i >= 0; i--) {
      indexes.add(chartData.length - 1 - i);
    }
    return indexes;
  }

  int getRandomInt(int min, int max) {
    final Random random = Random();
    final int result = min + random.nextInt(max - min);
    return result < 50 ? 95 : result;
  }

  @override
  void dispose() {
    seriesController = null;
    super.dispose();
  }
}

class ChartSampleData {
  int xValue;
  double y;
  ChartSampleData({
    required this.xValue,
    required this.y,
  });
}
