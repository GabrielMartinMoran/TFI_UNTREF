import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/device.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/providers/router_provider.dart';
import 'package:app/src/widgets/device_list_item.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatelessWidget {
  DevicesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerProvider = Provider.of<RouterProvider>(context);
    final devicesProvider = Provider.of<DevicesProvider>(context);
    return Scaffold(
        backgroundColor: Pallete.background,
        body: ListView(
          children: _body(devicesProvider),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Pallete.primary,
            foregroundColor: Pallete.background,
            tooltip: 'Agregar dispositivo',
            onPressed: () => routerProvider.navigateTo('/devices/add'),
            child: Icon(MdiIcons.plus)));
  }

  List<Widget> _body(DevicesProvider devicesProvider) {
    final List<Widget> children = [SizedBox(height: 5.0)];
    children.addAll(getDevicesListItems(devicesProvider.devices));
    return children;
  }

  List<DeviceListItem> getDevicesListItems(List<Device> devices) {
    List<DeviceListItem> items = [];
    for (var device in devices) {
      items.add(DeviceListItem(device));
    }
    return items;
  }
}
