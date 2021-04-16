class RouteResult {
  List<String> pathSegments;

  RouteResult(this.pathSegments);

  int paramsCount(String path) {
    return pathSegments.length - path.split('/').length;
  }

  List<String> getParams(String path) {
    final splittedPath = path.split('/');
    if (pathSegments.length - splittedPath.length > 1)
      return pathSegments.sublist(splittedPath.length);
    return [];
  }

  bool shouldRender(String path) {
    final splittedPath = path.split('/');
    if (splittedPath.length > pathSegments.length) return false;
    for (var i = 0; i < splittedPath.length; i++) {
      if (splittedPath[i] != pathSegments[i]) return false;
    }
    return true;
  }
}
