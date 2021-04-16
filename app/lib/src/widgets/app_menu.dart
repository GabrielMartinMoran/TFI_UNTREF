import 'package:app/src/configs/pallete.dart';
import 'package:app/src/widgets/menu_item.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key key}) : super(key: key);

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
                  return context.beamToNamed('/', beamBackOnPop: true);
                },
              ),
              MenuItem(
                  text: 'Mis dispositivos',
                  icon: Icons.bluetooth,
                  onTap: () {
                    var pages = context.currentBeamPages;
                    return context.beamToNamed('/devices', beamBackOnPop: true);
                    var beamer = Beamer.of(context);
                    beamer.beamToNamed('/devices',
                        beamBackOnPop: true, replaceCurrent: true);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
