import 'package:flutter/material.dart';

class StatefulScreen extends StatefulWidget {
  Function navigateTo;
  StatefulScreen({Key key}) : super(key: key);

  @override
  StatefulScreenState createState() => StatefulScreenState(navigateTo);
}

class StatefulScreenState extends State<StatefulScreen> {
  Function navigateTo;

  StatefulScreenState(this.navigateTo);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Base screen"),
      ),
    );
  }
}
