import 'package:http/http.dart' as http;

class BaseService {
  final String apiURL = 'http://10.0.2.2:5000';

  Future<http.Response> get(String route) async {
    return await http.get(Uri.parse('$apiURL$route'));
  }
}
