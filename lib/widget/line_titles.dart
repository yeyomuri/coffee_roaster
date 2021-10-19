import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value == 780)
              return 'min';
            else
              return value % 60 == 0 ? (value ~/ 60).toString() : '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value == 300)
              return '°C';
            else
              return value.toInt() % 20 == 0 ? '${value.toInt()}' : '';
          },
          reservedSize: 35,
          margin: 12,
        ),
        rightTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            if (value == 300)
              return '%';
            else
              return value.toInt() % 10 == 0 && value.toInt() % 20 == 0
                  ? '${value ~/ 10}'
                  : '';
          },
          reservedSize: 35,
          margin: 12,
        ),
      );
}
