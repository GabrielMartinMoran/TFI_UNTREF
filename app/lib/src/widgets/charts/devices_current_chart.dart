import 'package:app/src/models/device.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesCurrentChart extends StatelessWidget {
  const DevicesCurrentChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _getCharts(devicesProvider.devices),
    );
  }

  _getCharts(List<Device> devices) {
    List<Widget> charts = [];
    for (var device in devices) {
      List<FlSpot> dataSpots = [];
      for (var measurement in device.getLasBunchOfTime(0.1)) {
        dataSpots.add(FlSpot(measurement.timestamp, measurement.current));
      }
      charts.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 300,
          child: LineChart(_getLineChartData(dataSpots)),
        ),
      ));
      charts.add(SizedBox(
        height: 40,
      ));
    }
    return charts;
  }

  LineChartData _getLineChartData(List<FlSpot> spots) {
    // Checkear si spots es vacio
    double minX = spots[0].x;
    double maxX = spots[0].x;
    double minY = spots[0].y;
    double maxY = spots[0].y;
    for (var spot in spots) {
      if (spot.x < minX) minX = spot.x;
      if (spot.x > maxX) maxX = spot.x;
      if (spot.y < minY) minY = spot.y;
      if (spot.y > maxY) maxY = spot.y;
    }
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
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 8),
            getTitles: (value) {
              final date =
                  new DateTime.fromMicrosecondsSinceEpoch(value.toInt())
                      .toLocal();
              return '${date.hour}:${date.minute}:${date.second}';
            },
            margin: 8,
            rotateAngle: 75),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          getTitles: (value) {
            return '${value.roundToDouble()} A';
          },
          reservedSize: 15,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
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
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
