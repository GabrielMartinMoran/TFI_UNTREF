import 'package:app/src/models/route_result.dart';
import 'package:app/src/models/route_state.dart';
import 'package:app/src/screens/devices/add_device_screen.dart';
import 'package:app/src/screens/devices/devices_screen.dart';
import 'package:app/src/screens/devices/view_device_screen.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppNavigator extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  AppNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteState>(
      builder: (context, value, child) {
        final routeState = Provider.of<RouteState>(context);
        return WillPopScope(
          onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
          child: Navigator(
              key: _navigatorKey,
              pages: getPagesStack(routeState),
              onPopPage: (route, result) {
                return route.didPop(result);
              }),
        );
      },
    );
  }

  List<MaterialPage> getPagesStack(RouteState routeState) {
    final routed = RouteResult.fromRouteState(routeState);
    return [
      MaterialPage(key: ValueKey('home'), child: HomeScreen()),
      if (routed.shouldRender('devices'))
        MaterialPage(
          key: ValueKey('devices'),
          child: DevicesScreen(),
        ),
      if (routed.shouldRender('devices/add'))
        MaterialPage(
          key: ValueKey('add_device'),
          child: AddDeviceScreen(),
        ),
      if (routed.shouldRender('devices/view') &&
          routed.paramsCount('devices/view') == 1)
        MaterialPage(
          key: ValueKey('view_device'),
          child: ViewDeviceScreen(
              deviceId: int.parse(routed.getParams('devices/view')[0])),
        ),
    ];
  }

  static void navigateTo(BuildContext context, String uri) {
    Navigator.of(context).pop();
    Provider.of<RouteState>(context, listen: false).uri = uri;
  }
}
