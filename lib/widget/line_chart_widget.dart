import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mm_app/widget/line_titles.dart';

class LineChartWidget extends StatefulWidget {
  final List<FlSpot> perfilSpots;
  final double sensorValue;

  LineChartWidget(this.sensorValue, this.perfilSpots);
  @override
  _LineChartWidgetState createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  bool estadoCrack = false;
  bool estadoTimeCrack = true;
  bool estadoSensor = false;
  int timeCrack = 0;
  double dtr = 0;

  void startCreatedData() async {
    for (int i = 0; i < 720; i++) {
      if (i == 0) continue;
      await Future.delayed((Duration(seconds: 1))).then((value) {
        //DTR plot
        if (estadoCrack) {
          if (estadoTimeCrack) {
            timeCrack = i;
            estadoTimeCrack = false;
          }
          dtr = 1000 * (i.toDouble() - timeCrack) / i;
          flspotsDTR.add(
            FlSpot(
              double.parse(i.toString()),
              dtr,
            ),
          );
        }
        //Sensor plot
        flspots.add(
          FlSpot(
            double.parse(i.toString()),
            widget.sensorValue,
          ),
        );
        if (mounted) {
          setState(() {
            setChartData();
          });
        }
      });
    }
  }

  LineChartData data = LineChartData();
  void setChartData() {
    data = LineChartData(
        titlesData: LineTitles.getTitleData(),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.white, width: 1),
        ),
        minX: 0,
        maxX: 780,
        minY: 0,
        maxY: 300,
        lineBarsData: [
          LineChartBarData(
              spots: flspots,
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              )),
          LineChartBarData(
              spots: flspotsDTR,
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              )),
          LineChartBarData(
              spots: widget.perfilSpots,
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ))
        ]);
  }

  List<FlSpot> flspots = [
    FlSpot(0, 200),
  ];
  List<FlSpot> flspotsDTR = [
    FlSpot(0, 0),
  ];
  List<FlSpot> flspots2 = [
    FlSpot(0, 200),
    FlSpot(60, 100),
    FlSpot(120, 115),
    FlSpot(180, 125),
    FlSpot(240, 135),
    FlSpot(300, 143),
    FlSpot(360, 152),
    FlSpot(420, 161),
    FlSpot(480, 170),
    FlSpot(554, 178),
    FlSpot(600, 185),
    FlSpot(660, 190),
    FlSpot(720, 193),
  ];
  List<Color> gradientColors = [
    Colors.green,
    Colors.yellow,
    Colors.yellow[800],
  ];
  @override
  void initState() {
    super.initState();
    setChartData();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sensorValue >= widget.perfilSpots.first.y &&
        estadoSensor == false) {
      estadoSensor = true;
      startCreatedData();
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => estadoCrack = true,
                child: Text(estadoTimeCrack ? 'CRACK' : 'DTR: ${dtr ~/ 10}'),
                style: ElevatedButton.styleFrom(primary: Colors.yellow),
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.red),
                  Text(
                    'Gas',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.orange),
                  Text(
                    'Escape de aire',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.circle, color: Colors.blue),
                  Text(
                    'Velocidad',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.thermostat,
                    color: Colors.white,
                    size: 26,
                  ),
                  Text(
                    '${widget.sensorValue.toString()} °C',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: double.infinity, child: LineChart(data)),
        ],
      ),
    );
  }
}
