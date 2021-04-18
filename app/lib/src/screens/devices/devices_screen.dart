import 'package:app/src/providers/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatelessWidget {
  DevicesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerProvider = Provider.of<RouterProvider>(context);
    return Container(
      color: Colors.green,
      child: Center(
        child: ElevatedButton(
          onPressed: () => routerProvider.navigateTo('/devices/add'),
          child: Text("Agregar dispositivo"),
        ),
      ),
    );
  }
}
