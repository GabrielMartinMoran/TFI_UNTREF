import 'package:app/src/screens/base_screen.dart';
import 'package:flutter/material.dart';

class AddDeviceScreen extends BaseScreen {
  AddDeviceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text("ADD DEVICE"),
      ),
    );
  }
}
