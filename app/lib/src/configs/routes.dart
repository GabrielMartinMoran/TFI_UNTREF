import 'package:app/src/screens/devices/add_device_screen.dart';
import 'package:app/src/screens/devices/devices_screen.dart';
import 'package:app/src/screens/devices/view_device_screen.dart';
import 'package:app/src/screens/error_screen.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static final homeScreenGenerator = () => HomeScreen();

  static final errorScreenGenerator =
      (message) => ErrorScreen(message: message);

  /* 
    ¡¡¡IMPORTANTE!!!
    - No pueden existir rutas con parametros luego de otra ruta com parametros:
        Ejemplo de error: primero '/route1/<int>' y luego '/route1/<int>/route2
    - No puede haber partes fijas de la ruta luego de que comienzan los parametros:
        Ejemplo de error: '/route1_part1/<int>/route1_part2'
  */
  static final Map routes = {
    '/devices': () => DevicesScreen(),
    '/devices/add': () => AddDeviceScreen(),
    '/devices/view/<string>': (List<dynamic> args) =>
        ViewDeviceScreen(deviceBleId: args[0]),
  };

  static String routeOf(Widget widgetName) {
    return '';
  }
}
