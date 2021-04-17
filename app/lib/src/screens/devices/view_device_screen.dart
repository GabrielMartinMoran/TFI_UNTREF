import 'package:app/src/screens/stateless_screen.dart';
import 'package:flutter/material.dart';

class ViewDeviceScreen extends StatelessScreen {
  final int deviceId;
  ViewDeviceScreen({Key key, @required this.deviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('DEVICE ID: $deviceId'),
      ),
    );
  }
}
