import 'package:app/src/configs/assets.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/screens/stateful_screen.dart';
import 'package:app/src/screens/stateless_screen.dart';
import 'package:app/src/widgets/charts/devices_current_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
class HomeScreen extends StatelessScreen {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevicesCurrentChart();
  }
}
*/
class HomeScreen extends StatefulScreen {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen(navigateTo);
}

class _HomeScreen extends StatefulScreenState {
  var navigateTo;

  _HomeScreen(this.navigateTo) : super(navigateTo);

  @override
  Widget build(BuildContext context) {
    return DevicesCurrentChart();
  }
}
