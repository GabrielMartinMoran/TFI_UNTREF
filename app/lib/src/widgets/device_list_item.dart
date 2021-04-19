import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/device.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DeviceListItem extends StatelessWidget {
  final Device device;

  const DeviceListItem(this.device, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        padding: EdgeInsets.all(8.0),
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
                    SizedBox(height: 5.0),
                    Text(device.bleId,
                        style:
                            TextStyle(fontSize: 12, color: Pallete.chartText))
                  ]),
            ),
            Container(alignment: Alignment.bottomRight, child: _deviceStatus())
          ],
        ),
      ),
    );
  }

  Widget _deviceStatus() {
    List<Widget> children = [];
    if (device.active) {
      children = [
        Icon(MdiIcons.accessPoint, color: Pallete.ok),
        Text('activo', style: TextStyle(color: Pallete.ok))
      ];
    } else {
      children = [
        Icon(MdiIcons.accessPointOff, color: Pallete.danger),
        Text('inactivo', style: TextStyle(color: Pallete.danger))
      ];
    }
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: children);
  }
}
