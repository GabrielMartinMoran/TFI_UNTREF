import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseScreen extends StatelessWidget {
  Function navigateTo;
  BaseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Base screen"),
      ),
    );
  }
}
