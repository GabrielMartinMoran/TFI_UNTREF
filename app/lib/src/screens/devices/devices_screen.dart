import 'package:app/src/screens/stateless_screen.dart';
import 'package:flutter/material.dart';

class DevicesScreen extends StatelessScreen {
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
