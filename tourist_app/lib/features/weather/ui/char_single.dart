import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tourist_app/features/weather/models/weather_response_model.dart';

import '../../../cores/themes/colors.dart';

//Color test
//MultiLine chart

class WeatherChart2 extends StatelessWidget {
  final List<CurrentWeather> currentWeather;

  const WeatherChart2({Key? key, required this.currentWeather})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LineChart(
        lineCharData,
        swapAnimationDuration: const Duration(
          seconds: 5,
        ),
        swapAnimationCurve: Curves.linearToEaseOut,
      ),
    );
  }

  //LineCharData
  LineChartData get lineCharData {
    List<double> _xValues = spot1().map((e) => e.x).toList();
    List<double> _yValues = spot1().map((e) => e.y).toList();
    _xValues.sort(
      (a, b) => a.compareTo(b),
    );
    _yValues.sort(
      (a, b) => a.compareTo(b),
    );

    final double _minX = _xValues.first;
    final double _minY = _yValues.first;
    final double _maxX = _xValues.last;
    final double _maxY = _yValues.last;
    final showToolTipsIndex = spot1().map((e) => e.x.toInt()).toList();

    return LineChartData(
      //Danh sách các đối tượng được thể hiện trên đồ thị
      lineBarsData: listLineCharBarData,
      backgroundColor: Colors.transparent,
      //Các giá trị này có thể set theo giá trị đầu vào của spots
      minX: _minX,
      maxX: _maxX,
      maxY: _maxY * 4,
      minY: 0,
      // clipData: FlClipData.all(),
      //Cấu hình hiển thị lưới trong đồ thị
      gridData: FlGridData(
        show: false,
      ),
      //Hiển thị dữ liệu tương ứng trên đồ thị ( giá trị của trục Y )
      showingTooltipIndicators: showToolTipsIndex
          .map((element) => ShowingTooltipIndicators([
                LineBarSpot(
                  lineChartBarData1,
                  listLineCharBarData.indexOf(lineChartBarData1),
                  lineChartBarData1.spots[element],
                )
              ]))
          .toList(),
      //Cấu hình border xung quanh đồ thị
      borderData: FlBorderData(show: false, border: const Border()),
      lineTouchData: LineTouchData(
        enabled: true,
        //set false để luôn luôn hiển thị trên đồ thị
        handleBuiltInTouches: false,
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              //Đường thể hiện hình chiếu vuông góc với trục X
              FlLine(
                color: Colors.transparent,
              ),
              //Cấu hình hình dạng của các điểm trên đồ thị
              FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                  color: Colors.white,
                  radius: 3,
                  strokeWidth: 0.4,
                  strokeColor: Colors.white,
                ),
              ),
            );
          }).toList();
        },
        //Cấu hình widget thể hiện cho dữ liệu
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipRoundedRadius: 8,
          tooltipPadding: EdgeInsets.zero,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) => lineBarsSpot
              .map((lineBarSpot) => LineTooltipItem(
                    lineBarSpot.y.toString(),
                    Get.textTheme.bodyText1!.copyWith(color: Colors.white),
                  ))
              .toList(),
        ),
      ),
      //Cấu hình tiêu đề cho các cột.
      titlesData: setTitleChart,
      // betweenBarsData: listBetweenBarsData,
    );
  }

  //Danh sách biểu đồ được thể hiện trên đồ thị
  List<LineChartBarData> get listLineCharBarData => [
        lineChartBarData1,
        // lineChartBarData2,
        // lineChartBarData3,
      ];

  LineChartBarData get lineChartBarData1 {
    final showToolTipsIndex = spot1().map((e) => e.x.toInt()).toList();
    return LineChartBarData(
      barWidth: 1,
      shadow: const BoxShadow(
          color: Colors.white,
          blurRadius: 4,
          spreadRadius: 1.3,
          offset: Offset(0, -3)),
      spots: spot1(),
      color: AppColors.contentColorWhite,
      isCurved: true,
      curveSmoothness: 0.4,
      showingIndicators: showToolTipsIndex,
      dotData: FlDotData(
        show: false,
      ),
    );
  }

  //FlSpotData
  List<FlSpot> spot1() => currentWeather
      .map((e) => FlSpot(currentWeather.indexOf(e).toDouble(), e.temp ?? 0))
      .toList();

  FlTitlesData get setTitleChart => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles(),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        leftTitles: AxisTitles(
          axisNameSize: 20,
          // axisNameWidget: Text(
          //   'Cột',
          //   style: Get.textTheme.bodyText1,
          // ),
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      );

  SideTitles leftTitle() {
    return SideTitles(
      showTitles: false,
      reservedSize: 24,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        angle: 0,
        child: Text(
          value.toInt().toString(),
          style: Get.textTheme.bodyText2,
        ),
      ),
    );
  }

  SideTitles bottomTitles() {
    return SideTitles(
      showTitles: false,
      getTitlesWidget: (value, meta) => SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        angle: 0,
        child: AutoSizeText(
          value.toInt().toString(),
          style: Get.textTheme.bodyText2!.copyWith(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
