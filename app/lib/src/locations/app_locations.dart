import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/route_result.dart';
import 'package:app/src/screens/devices/add_device_screen.dart';
import 'package:app/src/screens/devices/devices_screen.dart';
import 'package:app/src/screens/devices/view_device_screen.dart';
import 'package:app/src/screens/error_screen.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:app/src/widgets/app_menu.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class AppLocations extends BeamLocation {
  AppLocations(BeamState state) : super(state);

  @override
  List<String> get pathBlueprints => ['/*'];

  @override
  List<BeamPage> pagesBuilder(BuildContext context, BeamState state) {
    print('LOCATION: ${state.uri.pathSegments}');
    var pages = routePages(state);
    // Si no puede mapear
    if (pages.length == 0) {
      pages.add(BeamPage(
        key: ValueKey('error'),
        child: renderChild(ErrorScreen()),
      ));
    }
    print('PAGES: $pages');
    return pages;
  }

  Widget renderChild(Widget child) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gestión de dispositivos'),
          backgroundColor: Pallete.gray,
        ),
        body: child,
        drawer: AppMenu());
  }

  List<BeamPage> routePages(BeamState state) {
    final routed = RouteResult(state.uri.pathSegments);
    return [
      // Home
      BeamPage(
        key: ValueKey('home'),
        child: renderChild(HomeScreen()),
      ),
      if (routed.shouldRender('devices'))
        BeamPage(
          key: ValueKey('devices'),
          child: renderChild(DevicesScreen()),
        ),
      if (routed.shouldRender('devices/add'))
        BeamPage(
          key: ValueKey('add_device'),
          child: renderChild(AddDeviceScreen()),
        ),
      if (routed.shouldRender('devices/view') &&
          routed.paramsCount('devices/view') == 1)
        BeamPage(
          key: ValueKey('view_device'),
          child: renderChild(ViewDeviceScreen(
              deviceId: int.parse(routed.getParams('devices/view')[0]))),
        ),
    ];
  }
}
