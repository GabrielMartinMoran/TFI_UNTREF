import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/charts/chart_bounds.dart';
import 'package:app/src/models/device.dart';
import 'package:app/src/utils/date_converter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DeviceCurrentChart extends StatelessWidget {
  final Device device;
  final double measurementsBunchMaxAge;
  final double timeInterval;
  double _currentInterval = 0;
  ChartBounds _chartBounds;
  List<FlSpot> _spots;
  DeviceCurrentChart(
      {Key key,
      @required this.device,
      @required this.timeInterval,
      @required this.measurementsBunchMaxAge})
      : super(key: key) {
    _generateChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        Text(device.name,
            style: TextStyle(fontSize: 20, color: Pallete.fontColor)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            child: LineChart(_getLineChartData()),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ]),
    );
  }

  void _generateChartData() {
    final filteredMeasurements =
        device.getLasBunchOfTime(measurementsBunchMaxAge);
    _spots = [];
    for (var measurement in filteredMeasurements) {
      _currentInterval += measurement.current;
      _spots.add(FlSpot(measurement.timestamp, measurement.current));
    }
    _currentInterval /= filteredMeasurements.length;
    _chartBounds = ChartBounds(_spots);
  }

  LineChartData _getLineChartData() {
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];
    return LineChartData(
      gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Pallete.chartLine,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Pallete.chartLine,
              strokeWidth: 1,
            );
          }),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => TextStyle(
                color: Pallete.chartText,
                fontWeight: FontWeight.bold,
                fontSize: 8),
            getTitles: (value) {
              DateTime date = DateConverter.fromTimestamp(value);
              return '${date.hour}:${date.minute}:${date.second}';
            },
            margin: 8,
            rotateAngle: 0,
            interval: timeInterval),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Pallete.chartText,
            fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          getTitles: (value) {
            if (value < 0.5) return '${(value * 1000).toStringAsFixed(1)} mA';
            return '${value.toStringAsFixed(2)} A';
          },
          reservedSize: 25,
          margin: 5,
          interval: _currentInterval,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Pallete.chartLine, width: 1)),
      minX: _chartBounds.minX,
      maxX: _chartBounds.maxX,
      minY: _chartBounds.minY -
          (_chartBounds.minY *
              0.1), //Restamos un 10% para que el minimo no quede abajo del todo
      maxY: _chartBounds.maxY *
          1.1, //Sumamos un 10% para que se vea la linea del maximo
      lineBarsData: [
        LineChartBarData(
            spots: _spots,
            isCurved: true,
            colors: gradientColors,
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
            preventCurveOverShooting: false),
      ],
    );
  }
}
