import 'package:http/http.dart' as http;

class WebService {
  static const Map<String, String> _headers = {
    'Content-type': 'application/json'
  };

  static Future<http.Response> webPost(String url, String requestBody) async {
    final response = await http.post(url, headers: _headers, body: requestBody);
    return response;
  }

  static Future<http.Response> webGet(String url, String requestBody) async {
    final response = await http.get(url, headers: _headers);
    return response;
  }
}
