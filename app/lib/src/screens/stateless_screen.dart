import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StatelessScreen extends StatelessWidget {
  Function navigateTo;
  StatelessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Base screen"),
      ),
    );
  }
}
