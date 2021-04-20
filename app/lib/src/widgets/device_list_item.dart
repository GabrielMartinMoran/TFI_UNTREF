import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/device.dart';
import 'package:app/src/providers/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DeviceListItem extends StatelessWidget {
  final Device device;

  const DeviceListItem(this.device, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerProvider = Provider.of<RouterProvider>(context);
    return TextButton(
      onPressed: () =>
          routerProvider.navigateTo('/devices/view/${device.bleId}'),
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Pallete.container, borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(device.name,
                        style:
                            TextStyle(fontSize: 20, color: Pallete.fontColor)),
                    SizedBox(height: 2.5),
                    Row(children: [
                      Text(device.bleId,
                          style: TextStyle(
                              fontSize: 12, color: Pallete.chartText)),
                      Expanded(child: SizedBox()),
                      _deviceStatus()
                    ])
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _deviceStatus() {
    List<Widget> children = [];
    final separator = SizedBox(width: 5.0);
    if (device.turnedOn) {
      children = [
        Text('encendido', style: TextStyle(color: Pallete.turnedOn)),
        separator,
        Icon(MdiIcons.lightbulbOn, color: Pallete.turnedOn)
      ];
    } else {
      children = [
        Text('apagado', style: TextStyle(color: Pallete.secondary)),
        separator,
        Icon(MdiIcons.lightbulbOff, color: Pallete.secondary)
      ];
    }
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: children);
  }
}
