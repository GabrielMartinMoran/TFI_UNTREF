import 'package:app/src/models/device.dart';
import 'package:app/src/models/route_state.dart';
import 'package:app/src/providers/devices_provider.dart';
import 'package:app/src/services/devices_service.dart';
import 'package:app/src/utils/date_converter.dart';
import 'package:app/src/utils/platform_checker.dart';
import 'package:app/src/widgets/routing/app_router_delegate.dart';
import 'package:app/src/widgets/routing/router_information_parser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!PlatformChecker.isWeb()) DateConverter.getLocalTimezone();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicesProvider>(
            create: (_) => DevicesProvider())
      ],
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Gestión de dispositivos',
          routeInformationParser: RouterInformationParser(),
          routerDelegate: AppRouterDelegate()),
    );
  }
}
