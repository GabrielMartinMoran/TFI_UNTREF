import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: ElevatedButton(
          onPressed: () => Beamer.of(context).beamToNamed('/devices/add'),
          child: Text("Agregar dispositivo"),
        ),
      ),
    );
  }
}
