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

  bool isSameRoute(String path) {
    return pathSegments.length == _splitPath(path).length;
  }

  int paramsCount(String path) {
    return pathSegments.length - _segmentsBeforeParams(path).length;
  }

  List<dynamic> getParams(String path) {
    if (paramsCount(path) <= 0) return [];
    List<dynamic> params = [];
    final routeSegments = _splitPath(path);
    final umparameteredRoute = _segmentsBeforeParams(path);
    List<String> strParams = routeSegments.sublist(umparameteredRoute.length);
    for (var i = 0; i < strParams.length; i++) {
      params.add(_parseParam(
          strParams[i], pathSegments[umparameteredRoute.length + i]));
    }
    return params;
  }

  bool shouldRender(String path) {
    final splittedPath = _splitPath(path);
    if (splittedPath.length > pathSegments.length) return false;
    for (var i = 0; i < splittedPath.length; i++) {
      if (splittedPath[i] != pathSegments[i] && !_isParam(splittedPath[i]))
        return false;
    }
    return true;
  }

  List<String> _segmentsBeforeParams(String uri) {
    List<String> segments = _splitPath(uri);
    List<String> filteredSegments = [];
    for (var i = 0; i < segments.length; i++) {
      if (_isParam(segments[i])) {
        break;
      } else {
        filteredSegments.add(segments[i]);
      }
    }
    return filteredSegments;
  }

  List<String> _splitPath(String path) {
    List<String> splitted = path.split('/');
    splitted.removeWhere((element) => element.isEmpty);
    return splitted;
  }

  dynamic _parseParam(String paramType, String value) {
    final parsers = {
      '<string>': (value) => value,
      '<int>': int.parse,
      '<double>': double.parse
    };
    if (parsers.containsKey(paramType)) return parsers[paramType](value);
    throw 'El parametro ingresado no posee un tipo valido que pueda ser interpretado';
  }

  bool _isParam(String value) {
    return value[0] == '<' && value[value.length - 1] == '>';
  }
}
