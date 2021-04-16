import 'package:app/src/models/route_state.dart';

class RouteResult {
  List<String> pathSegments;

  RouteResult(this.pathSegments);

  RouteResult.fromURI(String uri) {
    if (uri == null) {
      pathSegments = [];
      return;
    }
    pathSegments = _splitPath(uri);
  }

  RouteResult.fromRouteState(RouteState routeState) {
    this.pathSegments = _splitPath(routeState.uri);
    if (this.pathSegments.length > 0 && this.pathSegments[0].isEmpty)
      this.pathSegments.removeAt(0);
  }

  int paramsCount(String path) {
    return pathSegments.length - _splitPath(path).length;
  }

  List<String> getParams(String path) {
    if (paramsCount(path) <= 0) return [];
    return pathSegments.sublist(_splitPath(path).length);
  }

  bool shouldRender(String path) {
    final splittedPath = _splitPath(path);
    if (splittedPath.length > pathSegments.length) return false;
    for (var i = 0; i < splittedPath.length; i++) {
      if (splittedPath[i] != pathSegments[i]) return false;
    }
    return true;
  }

  List<String> _splitPath(String path) {
    List<String> splitted = path.split('/');
    splitted.removeWhere((element) => element.isEmpty);
    return splitted;
  }
}
