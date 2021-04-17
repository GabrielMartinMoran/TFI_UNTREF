import 'package:app/src/configs/assets.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/screens/base_screen.dart';
import 'package:app/src/widgets/charts/devices_current_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends BaseScreen {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return ListView(children: [DevicesCurrentChart()]);
  }
}
