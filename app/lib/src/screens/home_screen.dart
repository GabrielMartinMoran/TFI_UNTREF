import 'package:app/src/models/device.dart';
import 'package:app/src/models/measurement.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/widgets/charts/device_current_chart.dart';
import 'package:app/src/widgets/charts/device_power_chart.dart';
import 'package:app/src/widgets/header.dart';
import 'package:app/src/widgets/time_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Device> devices = [];
  double timeInterval = 30.0;
  double measurementsMaxAge = 120.0;

  @override
  Widget build(BuildContext context) {
    devices = Provider.of<DevicesProvider>(context).devices;
    final filteredMeasures = _getFilteredMeasurementsByAge();
    return ListView(children: [
      Header("Consumo total"),
      TimeSlider(
          onChange: (double value) => setState(() {
                measurementsMaxAge = value;
                timeInterval = measurementsMaxAge / 4;
              })),
      DeviceCurrentChart(
          measurements: filteredMeasures, timeInterval: timeInterval),
      DevicePowerChart(
          measurements: filteredMeasures, timeInterval: timeInterval)
    ]);
  }

  List<Measurement> _getFilteredMeasurementsByAge() {
    Map<double, Measurement> uniqueTimestampMeasurements = {};
    // Evitamos la duplicidad de los measurements que tengan el mismo timestamp
    for (var device in devices) {
      for (var measurement in device.getLasBunchOfTime(measurementsMaxAge)) {
        if (uniqueTimestampMeasurements.containsKey(measurement.timestamp)) {
          uniqueTimestampMeasurements[measurement.timestamp].current +=
              measurement.current;
          uniqueTimestampMeasurements[measurement.timestamp].power +=
              measurement.power;
        } else {
          uniqueTimestampMeasurements[measurement.timestamp] =
              measurement.clone();
        }
      }
    }
    List<Measurement> measurements =
        uniqueTimestampMeasurements.values.toList();
    measurements.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return measurements;
  }
}
