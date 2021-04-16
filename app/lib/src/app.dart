import 'package:app/src/locations/app_locations.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de dispositivos',
      routeInformationParser: BeamerRouteInformationParser(),
      routerDelegate:
          RootRouterDelegate(locationBuilder: (state) => AppLocations(state)),
    );
  }
}
