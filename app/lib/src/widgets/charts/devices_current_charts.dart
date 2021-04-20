/*import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/device.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/widgets/charts/device_current_chart.dart';
import 'package:app/src/widgets/header.dart';
import 'package:app/src/widgets/time_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesCurrentCharts extends StatefulWidget {
  const DevicesCurrentCharts({Key key}) : super(key: key);

  @override
  _DevicesCurrentChartsState createState() => _DevicesCurrentChartsState();
}

class _DevicesCurrentChartsState extends State<DevicesCurrentCharts> {
  double timeInterval = 30.0;
  double measurementsMaxAge = 120.0;

  @override
  Widget build(BuildContext context) {
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return Column(
      children: [
        Header("Corriente utilizada por dispositivo"),
        TimeSlider(
            onChange: (double value) => setState(() {
                  measurementsMaxAge = value;
                  timeInterval = measurementsMaxAge / 4;
                })),
        Column(
            children: _getCharts(
                devicesProvider.devices, timeInterval, measurementsMaxAge)),
      ],
    );
  }

  _getCharts(
      List<Device> devices, double timeInterval, double measurementsMaxAge) {
    List<Widget> charts = [];
    try {
      for (var device in devices) {
        charts.add(DeviceCurrentChart(
          device: device,
          timeInterval: timeInterval,
          measurementsBunchMaxAge: measurementsMaxAge,
          title: device.name,
        ));
      }
    } catch (e) {
      print('Ha ocurrido un error al generar los graficos');
    }
    return charts;
  }
}
*/
