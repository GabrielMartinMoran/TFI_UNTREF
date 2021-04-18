import 'package:app/src/providers/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDeviceScreen extends StatelessWidget {
  AddDeviceScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerProvider = Provider.of<RouterProvider>(context);
    return Container(
      color: Colors.red,
      child: Center(
        child: ElevatedButton(
          onPressed: () => routerProvider.navigateTo('/devices/view/2'),
          child: Text("Ver dispositivo 2"),
        ),
      ),
    );
  }
}
