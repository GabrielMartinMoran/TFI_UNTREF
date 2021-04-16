import 'package:app/src/configs/pallete.dart';
import 'package:app/src/models/route_result.dart';
import 'package:app/src/models/route_state.dart';
import 'package:app/src/screens/base_screen.dart';
import 'package:app/src/screens/devices/add_device_screen.dart';
import 'package:app/src/screens/devices/devices_screen.dart';
import 'package:app/src/screens/devices/view_device_screen.dart';
import 'package:app/src/screens/error_screen.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:app/src/widgets/app_menu.dart';
import 'package:flutter/material.dart';

class AppRouterDelegate extends RouterDelegate<RouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteState> {
  RouteState state;
  List<MaterialPage> _pages;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  RouteState get currentConfiguration {
    return state;
  }

  @override
  Widget build(BuildContext context) {
    _pages = getPagesStack();
    return Navigator(
      key: navigatorKey,
      pages: _pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(RouteState state) async {
    this.state = state;
  }

  @override
  Future<bool> popRoute() async {
    // Si solo tiene la home
    if (_pages.length == 1) return false;
    _pages.removeLast();
    navigateTo(_pages.last.name);
    return true;
  }

  List<MaterialPage> getPagesStack() {
    List<MaterialPage> pages = [
      MaterialPage(
          key: ValueKey('home'), name: '/', child: generateScreen(HomeScreen()))
    ];
    if (state == null) return pages;
    final routed = RouteResult.fromRouteState(state);
    if (routed == null || routed.pathSegments.length == 0) return pages;
    if (routed.shouldRender('devices'))
      pages.add(MaterialPage(
        key: ValueKey('devices'),
        name: 'devices',
        child: generateScreen(DevicesScreen()),
      ));
    if (routed.shouldRender('devices/add'))
      pages.add(MaterialPage(
        key: ValueKey('devices/add'),
        name: 'devices/add',
        child: generateScreen(AddDeviceScreen()),
      ));
    if (routed.shouldRender('devices/view') &&
        routed.paramsCount('devices/view') == 1)
      pages.add(MaterialPage(
        key: ValueKey('devices/view'),
        name: 'devices/view',
        child: generateScreen(ViewDeviceScreen(
            deviceId: int.parse(routed.getParams('devices/view')[0]))),
      ));
    if (pages.length == 1)
      pages.add(MaterialPage(
        key: ValueKey('error'),
        name: state.uri,
        child: generateScreen(ErrorScreen()),
      ));
    return pages;
  }

  Widget generateScreen(BaseScreen child) {
    child.navigateTo = this.navigateTo;
    return Scaffold(
        appBar: AppBar(
          title: Text('Gestión de dispositivos'),
          backgroundColor: Pallete.gray,
        ),
        body: child,
        drawer: AppMenu(navigateTo: this.navigateTo));
  }

  void navigateTo(String uri) {
    state = RouteState.fromURI(uri);
    notifyListeners();
  }
}
