import 'package:app/src/screens/base_screen.dart';
import 'package:flutter/material.dart';

class ViewDeviceScreen extends BaseScreen {
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
