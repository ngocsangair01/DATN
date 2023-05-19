/// dart import
import 'dart:math';

/// Package import
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/weather_response_model.dart';

/// Local imports
/// Renders the chart with default trackball sample.
class LineChart extends StatelessWidget {
  /// Creates the chart with default trackball sample.
  LineChart({Key? key, required this.currentWeather}) : super(key: key);
  final List<CurrentWeather> currentWeather;
  late List<ChartSampleData> chartData;

  @override
  Widget build(BuildContext context) {
    chartData = currentWeather
        .map((e) => ChartSampleData(xValue: e.dateTime!, y: e.temp!))
        .toList();
    return _buildInfiniteScrollingChart();
  }

  /// Returns the cartesian chart with default trackball.
  SfCartesianChart _buildInfiniteScrollingChart() {
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        autoScrollingMode: AutoScrollingMode.start,
        labelStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
        // majorTickLines: const MajorTickLines(color: Colors.red),
        majorGridLines: const MajorGridLines(width: 0),
        intervalType: DateTimeIntervalType.auto,
      ),
      primaryYAxis: NumericAxis(
          labelStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.white)),
      //can scroll
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
      ),
      plotAreaBorderColor: Colors.black,
      series: getSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
      trackballBehavior: TrackballBehavior(
        shouldAlwaysShow: true,
        enable: true,
        activationMode: ActivationMode.none,
        tooltipSettings: const InteractiveTooltip(
            format: 'point.x : point.y', color: Colors.transparent),
      ),
    );
  }

  List<ChartSeries<ChartSampleData, DateTime>> getSeries() {
    return <ChartSeries<ChartSampleData, DateTime>>[
      SplineSeries<ChartSampleData, DateTime>(
          dataSource: chartData,
          color: Colors.white,
          enableTooltip: true,
          xValueMapper: (sales, _) => sales.xValue,
          yValueMapper: (sales, _) => sales.y,
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              color: Colors.black,
              textStyle: Get.textTheme.bodyText1!.copyWith(color: Colors.white),
              labelPosition: ChartDataLabelPosition
                  .outside, // Places the data labels outside the pie area
              // By setting the below property to none value, does not hides the data label that are getting hidden due to intersection
              labelIntersectAction: LabelIntersectAction.none)),
    ];
  }
}

class ChartSampleData {
  DateTime xValue;
  double y;
  ChartSampleData({
    required this.xValue,
    required this.y,
  });
}
