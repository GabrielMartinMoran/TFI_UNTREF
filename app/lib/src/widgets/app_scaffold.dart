import 'package:app/src/configs/pallete.dart';
import 'package:app/src/widgets/menu/app_menu.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final Function navigateTo;
  const AppScaffold({Key key, @required this.child, @required this.navigateTo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gestión de dispositivos'),
          backgroundColor: Pallete.container,
        ),
        body: child,
        backgroundColor: Pallete.background,
        drawer: AppMenu(navigateTo: navigateTo));
  }
}
