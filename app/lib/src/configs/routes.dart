import 'package:app/src/screens/devices/add_device_screen.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final Map routes = {
    '/': () => HomeScreen(),
    '/add_device': () => AddDeviceScreen(),
  };

  static String routeOf(Widget widgetName) {
    return '';
  }
}
