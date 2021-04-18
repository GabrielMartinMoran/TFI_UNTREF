import 'package:app/src/widgets/charts/devices_current_charts.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [DevicesCurrentCharts()]); //DevicesCurrentCharts();
  }
}
