import 'package:app/src/utils/platform_checker.dart';
import 'package:http/http.dart' as http;

class BaseService {
  String apiURL = 'http://10.0.2.2:5000';

  BaseService() {
    if (PlatformChecker.isWeb()) {
      apiURL = 'http://localhost:5000';
    }
  }

  Future<http.Response> get(String route) async {
    return await http.get(Uri.parse('$apiURL$route'));
  }
}
