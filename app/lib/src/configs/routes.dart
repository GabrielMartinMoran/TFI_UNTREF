import 'package:app/src/screens/devices/add_device_screen.dart';
import 'package:app/src/screens/devices/devices_screen.dart';
import 'package:app/src/screens/devices/view_device_screen.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map routes = {
    '/': () => HomeScreen(),
    '/devices': () => DevicesScreen(),
    '/devices/add': () => AddDeviceScreen(),
    '/devices/view/<int>': (List<dynamic> args) =>
        ViewDeviceScreen(deviceId: args[0]),
  };

  static String routeOf(Widget widgetName) {
    return '';
  }
}
