import 'package:flutter/material.dart';

class ViewDeviceScreen extends StatelessWidget {
  final int deviceId;
  const ViewDeviceScreen({Key key, @required this.deviceId}) : super(key: key);

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
