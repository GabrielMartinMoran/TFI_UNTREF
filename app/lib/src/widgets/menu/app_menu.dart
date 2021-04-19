import 'package:app/src/configs/pallete.dart';
import 'package:app/src/providers/router_provider.dart';
import 'package:app/src/widgets/menu/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

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
    final routerProvider = Provider.of<RouterProvider>(context);
    return SafeArea(
      child: Drawer(
        child: Container(
          color: Pallete.container,
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
                    return routerProvider.navigateTo('/');
                    //return navigateTo('/');
                  }),
              MenuItem(
                  text: 'Mis dispositivos',
                  icon: MdiIcons.monitorMultiple,
                  onTap: () {
                    //return Navigator.of(context).pushNamed('/devices');
                    return routerProvider.navigateTo('/devices');
                    //return navigateTo('/devices');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
