import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/measurement.dart';
import 'package:app/src/widgets/charts/gradient_line_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DevicePowerChart extends StatelessWidget {
  final List<Measurement> measurements;
  final double timeInterval;
  final String title;
  List<FlSpot> _spots;
  DevicePowerChart(
      {Key key,
      @required this.measurements,
      @required this.timeInterval,
      this.title})
      : super(key: key) {
    _generateChartData();
  }

  @override
  Widget build(BuildContext context) {
    return GradientLineChart(
      _spots ?? [],
      timeInterval ?? 0,
      Pallete.powerGradient,
      title: title ?? 'Consumo de potencia',
      unit: 'W',
    );
  }

  void _generateChartData() {
    _spots = [];
    for (var measurement in measurements) {
      _spots.add(FlSpot(measurement.timestamp, measurement.power));
    }
  }
}
