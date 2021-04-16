import 'package:app/src/screens/base_screen.dart';
import 'package:flutter/material.dart';

class DevicesScreen extends BaseScreen {
  DevicesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: ElevatedButton(
          onPressed: () => navigateTo('/devices/add'),
          child: Text("Agregar dispositivo"),
        ),
      ),
    );
  }
}
