import 'package:app/src/configs/pallete.dart';
import 'package:app/src/widgets/menu/menu_item.dart';
import 'package:flutter/material.dart';

class AppMenu extends StatefulWidget {
  final Function navigateTo;
  const AppMenu({Key key, this.navigateTo}) : super(key: key);

  @override
  _AppMenuState createState() => _AppMenuState(navigateTo);
}

class _AppMenuState extends State<AppMenu> {
  final Function navigateTo;

  _AppMenuState(this.navigateTo);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Pallete.gray,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              MenuItem(
                  text: 'Inicio',
                  icon: Icons.home,
                  onTap: () {
                    //return Navigator.of(context).pushNamed('/');
                    return navigateTo('/');
                  }),
              MenuItem(
                  text: 'Mis dispositivos',
                  icon: Icons.bluetooth,
                  onTap: () {
                    //return Navigator.of(context).pushNamed('/devices');
                    return navigateTo('/devices');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
