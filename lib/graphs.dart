import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

//------------------------------- Calories Graph ----------------------

List<Color> gradientColors = [
  kBlue,
  Colors.blue,
];

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Week 1', style: style);
      break;
    case 4:
      text = const Text('Week 2', style: style);
      break;
    case 8:
      text = const Text('Week 3', style: style);
      break;
    case 12:
      text = const Text('Week 4', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    meta: meta,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '0';
      break;
    case 2:
      text = '450';
      break;
    case 4:
      text = '900';
      break;
    case 6:
      text = '1350';
      break;
    case 8:
      text = '1800';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: kBlue,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: kBlue,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 2,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 2,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border(
        right: BorderSide.none,
        left: BorderSide(),
        bottom: BorderSide(),
      ),
    ),
    minX: 0,
    maxX: 12,
    minY: 0,
    maxY: 8,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 4),
          FlSpot(4, 6),
          FlSpot(8, 4),
          FlSpot(12, 7),
         
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors
                .map((color) => color.withValues(alpha: 0.3))
                .toList(),
          ),
        ),
      ),
    ],
  );
}

LineChartData avgData() {
  return LineChartData(
    lineTouchData: const LineTouchData(enabled: false),
    gridData: FlGridData(
      show: false,
      drawHorizontalLine: true,
      verticalInterval: 1,
      horizontalInterval: 1,
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: bottomTitleWidgets,
          interval: 1,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
          interval: 1,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border(
        right: BorderSide.none,
        left: BorderSide(),
        bottom: BorderSide(),
      ),
    ),
    minX: 0,
    maxX: 12,
    minY: 0,
    maxY: 8,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3.44),
          FlSpot(2.6, 3.44),
          FlSpot(4.9, 3.44),
          FlSpot(6.8, 3.44),
          FlSpot(8, 3.44),
          FlSpot(9.5, 3.44),
          FlSpot(12, 3.44),
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withValues(alpha: 0.1),
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withValues(alpha: 0.1),
            ],
          ),
        ),
      ),
    ],
  );
}

//------------------------------- Workout bar graph ----------------------
