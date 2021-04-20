import 'dart:math';

import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/charts/chart_bounds.dart';
import 'package:app/src/utils/date_converter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GradientLineChart extends StatelessWidget {
  final double timeInterval;
  final List<FlSpot> dataSpots;
  final List<Color> colorGradient;
  final String title;
  final String unit;
  double yAverage;
  ChartBounds _chartBounds;
  double _verticalInterval;

  GradientLineChart(this.dataSpots, this.timeInterval, this.colorGradient,
      {Key key, this.title, this.unit})
      : super(key: key) {
    _calculateInterval();
    _chartBounds = ChartBounds(dataSpots);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        if (title != null)
          Text(title, style: TextStyle(fontSize: 20, color: Pallete.fontColor)),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Máximo: ${_formatLabel(_getMax())}',
                style: TextStyle(fontSize: 15, color: Pallete.chartText)),
            Text('Actual: ${_formatLabel(_getLast())}',
                style: TextStyle(fontSize: 15, color: Pallete.chartText)),
            Text('Promedio: ${_formatLabel(yAverage)}',
                style: TextStyle(fontSize: 15, color: Pallete.chartText)),
          ]),
        ),
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

  void _calculateInterval() {
    yAverage = 0;
    for (var spot in dataSpots) {
      yAverage += spot.y;
    }
    yAverage /= dataSpots.length;
    _verticalInterval = yAverage / 4;
  }

  double _getMax() {
    if (dataSpots != null && dataSpots.isNotEmpty)
      return dataSpots.reduce((a, b) => a.y > b.y ? a : b).y;
    return 0;
  }

  double _getLast() {
    if (dataSpots != null && dataSpots.isNotEmpty) return dataSpots.last.y;
    return 0;
  }

  String _formatLabel(double value) {
    if (value > 1000) return '${(value / 1000).toStringAsFixed(2)} K$unit';
    if (value < (1 / 100)) return '${(value * 1000).toStringAsFixed(2)} m$unit';
    return '${value.toStringAsFixed(2)} $unit';
  }

  LineChartData _getLineChartData() {
    return LineChartData(
        gridData: FlGridData(
            verticalInterval: timeInterval > 0 ? timeInterval : 1,
            horizontalInterval: _verticalInterval > 0 ? _verticalInterval : 1,
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
              getTextStyles: (value) => TextStyle(
                  color: Pallete.chartText,
                  fontWeight: FontWeight.bold,
                  fontSize: 8),
              getTitles: (value) {
                DateTime date = DateConverter.fromTimestamp(value);
                return '${date.hour}:${date.minute}:${date.second}';
              },
              reservedSize: 22,
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
            getTitles: (double value) => _formatLabel(value),
            reservedSize: 30,
            margin: 5,
            interval: _verticalInterval,
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
              spots: dataSpots,
              isCurved: true,
              colors: colorGradient,
              barWidth: 5,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: colorGradient
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              )),
        ],
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Pallete.container,
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((spot) {
                    return LineTooltipItem(
                        _formatLabel(spot.y),
                        TextStyle(
                            color: Pallete.fontColor,
                            fontWeight: FontWeight.bold));
                  }).toList();
                })));
  }
}
