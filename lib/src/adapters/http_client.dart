import 'dart:convert';
import 'package:http/http.dart' as http;

/// HTTP Client adapter for [HttpClient]
abstract class HttpClientAdapter {
  /// Send a GET request
  /// "This function returns a future that resolves to an http.Response object".
  ///
  /// The `async` keyword tells Dart that this function will be asynchronous. The `await` keyword tells Dart that this function will be asynchronous.
  /// tells Dart to wait for the future to resolve before continuing.
  ///
  /// Args:
  /// url (String): the url to make the request.
  /// headers (Map<String, String>): A map of headers to be sent with the request.
  ///
  /// Returns:
  /// A future<http.Response>.
  static Future<http.Response> get(
      {required String url, Map<String, String>? headers}) async {
    return http.get(Uri.parse(url), headers: headers);
  }

  /// Send a POST request
  /// Makes a POST request to the given URL with the given headers and body.
  ///
  /// Args:
  /// url (String): the url to which the request is to be made.
  /// headers (Map<String, String>): A map of headers that will be sent with the request.
  /// body (Map<String, dynamic>): The body of the request.
  ///
  /// Returns:
  /// A future<http.Response>.
  static Future<http.Response> post(
      {required String url,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    return http.post(Uri.parse(url), headers: headers, body: json.encode(body));
  }
}
