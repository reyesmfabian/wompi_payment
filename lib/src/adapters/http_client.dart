import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class HttpClientAdapter {
  static Future<http.Response> get(
      {required String url, Map<String, String>? headers}) async {
    return http.get(Uri.parse(url), headers: headers);
  }

  static Future<http.Response> post(
      {required String url,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    return http.post(Uri.parse(url), headers: headers, body: json.encode(body));
  }
}
