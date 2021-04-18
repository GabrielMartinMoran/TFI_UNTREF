import 'dart:async';

import 'package:app/src/models/device.dart';
import 'package:app/src/services/devices_service.dart';
import 'package:flutter/material.dart';

class RouterProvider {
  Function navigateTo = (route) => null;

  // Quizas se puede agregar el tipo de la pantalla que se esta mostrando actualmente
  /*
  Function get navigateTo => _navigateTo;

  set navigateTo(Function value) {
    _navigateTo = value;
  }*/
}
