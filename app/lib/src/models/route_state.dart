import 'package:flutter/material.dart';

class RouteState with ChangeNotifier {
  String _uri = '/';

  RouteState();

  RouteState.fromURI(this._uri);

  String get uri => _uri;

  set uri(String value) {
    _uri = value;
    notifyListeners();
  }
}
