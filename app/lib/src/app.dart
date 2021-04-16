import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/route_state.dart';
import 'package:app/src/widgets/app_menu.dart';
import 'package:app/src/widgets/app_navigator.dart';
import 'package:app/src/widgets/app_router_delegate.dart';
import 'package:app/src/widgets/router_information_parser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RouteState>(create: (_) => RouteState())
      ],
      /*child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gestión de dispositivos',
          home: Scaffold(
              appBar: AppBar(
                title: Text('Gestión de dispositivos'),
                backgroundColor: Pallete.gray,
              ),
              body: MaterialApp.router(
                  routeInformationParser: RouterInformationParser(),
                  routerDelegate: AppRouterDelegate()),
              drawer: AppMenu())),*/
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Gestión de dispositivos',
          routeInformationParser: RouterInformationParser(),
          routerDelegate: AppRouterDelegate()),
    );
  }
}
