import 'dart:async';

import 'package:app/src/models/device.dart';
import 'package:app/src/services/devices_service.dart';
import 'package:flutter/material.dart';

class DevicesProvider with ChangeNotifier {
  List<Device> _devices = [];
  DevicesService service;
  Timer timer;

  DevicesProvider() {
    service = new DevicesService();
    _getData();
    _setupPeriodicDataGetter();
  }

  List<Device> get devices => _devices;

  set devices(List<Device> value) {
    _devices = value;
    notifyListeners();
  }

  void _setupPeriodicDataGetter() {
    const delay = const Duration(seconds: 20);
    timer = Timer.periodic(delay, (Timer t) => _getData());
  }

  void _getData() {
    try {
      service.getDevicesData().then((res) => devices = res);
    } catch (e) {
      print(
          'Ha ocurrido un error al tratar de obtener datos de los dispositivos: $e');
    }
  }
}
