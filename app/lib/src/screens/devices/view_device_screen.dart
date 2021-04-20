import 'package:app/src/models/device.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/widgets/charts/device_current_chart.dart';
import 'package:app/src/widgets/charts/device_power_chart.dart';
import 'package:app/src/widgets/header.dart';
import 'package:app/src/widgets/time_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDeviceScreen extends StatefulWidget {
  final String deviceBleId;
  ViewDeviceScreen({Key key, @required this.deviceBleId}) : super(key: key);

  @override
  _ViewDeviceScreenState createState() => _ViewDeviceScreenState();
}

class _ViewDeviceScreenState extends State<ViewDeviceScreen> {
  double timeInterval = 30.0;
  double measurementsMaxAge = 120.0;

  @override
  Widget build(BuildContext context) {
    final device = _getDevice(context);
    return ListView(children: [
      Header(device.name),
      Header(device.bleId),
      TimeSlider(
          onChange: (double value) => setState(() {
                measurementsMaxAge = value;
                timeInterval = measurementsMaxAge / 4;
              })),
      DeviceCurrentChart(
          measurements: device.getLasBunchOfTime(measurementsMaxAge),
          timeInterval: timeInterval),
      DevicePowerChart(
          measurements: device.getLasBunchOfTime(measurementsMaxAge),
          timeInterval: timeInterval)
    ]);
  }

  Device _getDevice(BuildContext context) {
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return devicesProvider.devices
        .firstWhere((x) => x.bleId == widget.deviceBleId);
  }
}
