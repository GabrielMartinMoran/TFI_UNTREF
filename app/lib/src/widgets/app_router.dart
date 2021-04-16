import 'package:app/src/screens/devices/add_device_screen.dart';
import 'package:app/src/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter extends StatefulWidget {
  final Map routes;
  AppRouter({Key key, this.routes}) : super(key: key);

  @override
  _AppRouterState createState() => _AppRouterState(routes);
}

class _AppRouterState extends State<AppRouter> {
  final Map routes;
  _AppRouterState(this.routes);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        //pages: _getPages(context),
        onPopPage: (route, result) {
      return route.didPop(result);
    }, onGenerateRoute: (settings) {
      return generateRoute(settings);
    });
  }

  List<MaterialPage<Widget>> _getPages(BuildContext context) {
    /*List<Page<dynamic>> pages = [];
    for (var routeKey in routes.keys) {
      pages.add(MaterialPage(key: ValueKey(routeKey), child: Container()));
    }
    return pages;
    */
    return [
      MaterialPage(child: HomeScreen(), key: ValueKey('/')),
      MaterialPage(child: AddDeviceScreen(), key: ValueKey('/add_device'))
    ];
  }

  _GeneratePageRoute generateRoute(RouteSettings settings) {
    print('> Navigate to: ${settings.name}');
    String redirectedRoute = '/';
    if (settings.name != null) {
      redirectedRoute = settings.name;
    }
    return _GeneratePageRoute(
        routeName: redirectedRoute, widget: routes[redirectedRoute]());
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({this.widget, this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
