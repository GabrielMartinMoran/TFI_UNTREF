import 'package:app/src/configs/assets.dart';
import 'package:app/src/screens/base_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseScreen {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Image.asset(Assets.logo)));
  }
}
