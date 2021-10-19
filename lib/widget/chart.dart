import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample5 extends StatelessWidget {
  final List<int> showIndexes = const [0, 1, 2, 3, 4];
  final List<FlSpot> allSpots = [
    FlSpot(0, 20), //a
    FlSpot(6, 10), //b
    FlSpot(20, 14), //c
    FlSpot(40, 17), //d
    FlSpot(72, 19), //e
  ];

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
          showingIndicators: showIndexes,
          spots: allSpots,
          isCurved: true,
          barWidth: 4,
          shadow: const Shadow(
            blurRadius: 8,
            color: Colors.black,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              Colors.green,
              Colors.yellow,
              Colors.yellow[800]!,
            ],
          ),
          dotData: FlDotData(show: false),
          colors: [
            Colors.green,
            Colors.yellow,
            Colors.yellow[800]!,
          ],
          colorStops: [
            0.1,
            0.4,
            0.9
          ]),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return SizedBox(
      width: 300,
      height: 140,
      child: LineChart(
        LineChartData(
          showingTooltipIndicators: showIndexes.map((index) {
            return ShowingTooltipIndicators(/*index, */ [
              LineBarSpot(tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar),
                  tooltipsOnBar.spots[index]),
            ]);
          }).toList(),
          lineTouchData: LineTouchData(
            enabled: false,
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> spotIndexes) {
              return spotIndexes.map((index) {
                return TouchedSpotIndicatorData(
                  FlLine(
                    color: Color.fromRGBO(255, 255, 255, 0),
                  ),
                  FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 8,
                      color: lerpGradient(
                          barData.colors, barData.colorStops ?? [], percent / 100),
                      strokeWidth: 2,
                      strokeColor: Color.fromRGBO(0, 0, 0, 0.2),
                    ),
                  ),
                );
              }).toList();
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Color.fromRGBO(194, 155, 97, 0.3),
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                return lineBarsSpot.map((lineBarSpot) {
                  return LineTooltipItem(
                    lineBarSpot.x.toInt() == 0
                        ? 'as,a°C'
                        : lineBarSpot.x.toInt() == 6
                            ? 'bs,b°C'
                            : lineBarSpot.x.toInt() == 20
                                ? 'cs,c°C'
                                : lineBarSpot.x.toInt() == 40
                                    ? 'ds,d°C'
                                    : lineBarSpot.x.toInt() == 72
                                        ? 'es,e°C'
                                        : '',
                    const TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
          lineBarsData: lineBarsData,
          minY: 0,
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
                showTitles: false,
                getTitles: (val) {
                  return '';
                },
                getTextStyles: (context, value) => const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white60,
                      fontFamily: 'Digital',
                      fontSize: 18,
                    )),
          ),
          axisTitleData: FlAxisTitleData(
            leftTitle: AxisTitle(
              reservedSize: 20,
              showTitle: true,
              titleText: 'Grado Celsius (°C)',
              textStyle: TextStyle(color: Colors.white60),
            ),
            bottomTitle: AxisTitle(
              showTitle: true,
              titleText: 'Segundos (s)',
              textStyle: TextStyle(color: Colors.white60),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: false,
          ),
        ),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color? lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / colors.length;
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      double sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT);
    }
  }
  return colors.last;
}
