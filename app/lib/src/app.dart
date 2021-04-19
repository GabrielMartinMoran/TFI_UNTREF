import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/providers/router_provider.dart';
import 'package:app/src/widgets/routing/app_router_delegate.dart';
import 'package:app/src/widgets/routing/router_information_parser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicesProvider>(
            create: (_) => DevicesProvider()),
        Provider<RouterProvider>(create: (_) => RouterProvider())
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Gestión de dispositivos',
          routeInformationParser: RouterInformationParser(),
          routerDelegate: AppRouterDelegate()),
    );
  }
}
