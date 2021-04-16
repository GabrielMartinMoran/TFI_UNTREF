import 'package:app/src/models/route_state.dart';
import 'package:flutter/material.dart';

class RouterInformationParser extends RouteInformationParser<RouteState> {
  @override
  Future<RouteState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    return RouteState.fromURI(uri.path);
  }

  @override
  RouteInformation restoreRouteInformation(RouteState routeState) {
    return RouteInformation(location: routeState.uri);
  }
}
