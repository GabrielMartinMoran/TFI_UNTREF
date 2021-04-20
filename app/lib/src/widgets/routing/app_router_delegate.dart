import 'package:app/src/configs/routes.dart';
import 'package:app/src/models/route_result.dart';
import 'package:app/src/models/route_state.dart';
import 'package:app/src/providers/router_provider.dart';
import 'package:app/src/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final routerProvider = Provider.of<RouterProvider>(context);
    routerProvider.navigateTo = navigateTo;
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
          key: ValueKey('/'),
          name: '/',
          child: generateScreen(Routes.homeScreenGenerator()))
    ];
    if (state == null) return pages;
    final routed = RouteResult.fromRouteState(state);
    if (routed == null || routed.pathSegments.length == 0) return pages;

    try {
      for (var route in Routes.routes.keys) {
        addRouteIfRequired(routed, pages, route, Routes.routes[route]);
      }
    } on TypeError catch (e) {
      print(e);
      addErrorPage(pages,
          'Ha ocurrido un error al tratar de procesar los parametros de la página');
    } catch (e) {
      print(e);
      addErrorPage(pages, e.toString());
    }

    if (pages.length == 1)
      addErrorPage(pages, 'Parece la dirección ingresada no es válida');
    return pages;
  }

  void addRouteIfRequired(RouteResult routeResult, List<MaterialPage> pages,
      String path, Function screenGenerator) {
    if (!routeResult.shouldRender(path)) return;
    Widget screen;
    if (!routeResult.isSameRoute(path) || routeResult.paramsCount(path) == 0) {
      screen = screenGenerator();
    } else {
      screen = screenGenerator(routeResult.getParams(path));
    }
    pages.add(MaterialPage(
        key: ValueKey(path), name: path, child: generateScreen(screen)));
  }

  Widget generateScreen(Widget child) =>
      AppScaffold(navigateTo: navigateTo, child: child);

  void addErrorPage(pages, String message) {
    pages.add(MaterialPage(
      key: ValueKey('error'),
      name: 'error',
      child: generateScreen(Routes.errorScreenGenerator(message)),
    ));
  }

  void navigateTo(String uri) {
    state = RouteState.fromURI(uri);
    notifyListeners();
  }
}
