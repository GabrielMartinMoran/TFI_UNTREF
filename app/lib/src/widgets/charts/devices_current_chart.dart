import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/charts/chart_bounds.dart';
import 'package:app/src/models/device.dart';
import 'package:app/src/models/measurement.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/utils/date_converter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesCurrentChart extends StatelessWidget {
  const DevicesCurrentChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return ListView(children: _getCharts(devicesProvider.devices, 120.0));
    /*Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getCharts(devicesProvider.devices, 120.0),
    );*/
  }

  _getCharts(List<Device> devices, double interval) {
    List<Widget> charts = [];
    for (var device in devices) {
      List<FlSpot> dataSpots = [];
      double currentInterval = 0;
      final filteredMeasurements = device.getLasBunchOfTime(interval);
      for (var measurement in filteredMeasurements) {
        currentInterval += measurement.current;
        dataSpots.add(FlSpot(measurement.timestamp, measurement.current));
      }
      currentInterval /= filteredMeasurements.length;
      charts.add(Column(children: [
        SizedBox(
          height: 10,
        ),
        Text(device.name,
            style: TextStyle(fontSize: 20, color: Pallete.fontColor)),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            child:
                LineChart(_getLineChartData(dataSpots, 30.0, currentInterval)),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ]));
    }
    return charts;
  }

  LineChartData _getLineChartData(
      List<FlSpot> spots, double xInterval, double yInterval) {
    final bounds = ChartBounds(spots);
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
            interval: xInterval),
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
          interval: yInterval,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Pallete.chartLine, width: 1)),
      minX: bounds.minX,
      maxX: bounds.maxX,
      minY: bounds.minY -
          (bounds.minY *
              0.1), //Restamos un 10% para que el minimo no quede abajo del todo
      maxY: bounds.maxY *
          1.1, //Sumamos un 10% para que se vea la linea del maximo
      lineBarsData: [
        LineChartBarData(
            spots: spots,
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
