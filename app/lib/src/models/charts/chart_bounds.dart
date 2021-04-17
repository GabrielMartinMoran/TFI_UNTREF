import 'package:fl_chart/fl_chart.dart';

class ChartBounds {
  double minX = 0;
  double minY = 0;
  double maxX = 0;
  double maxY = 0;

  ChartBounds(List<FlSpot> spots) {
    if (spots.length == 0) return;
    minX = spots[0].x;
    minY = spots[0].y;
    maxX = spots[0].x;
    maxY = spots[0].y;
    for (var spot in spots) {
      if (spot.x < minX) minX = spot.x;
      if (spot.y < minY) minY = spot.y;
      if (spot.x > maxX) maxX = spot.x;
      if (spot.y > maxY) maxY = spot.y;
    }
  }
}
