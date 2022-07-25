import 'dart:convert';
import 'package:http/http.dart' as http;

/// HTTP Client adapter for [HttpClient]
abstract class HttpClientAdapter {
  /// Send a GET request
  /// "Esta función devuelve un futuro que se resuelve en un objeto http.Response".
  ///
  /// La palabra clave `async` le dice a Dart que esta función será asíncrona. La palabra clave `await` le
  /// dice a Dart que espere a que el futuro se resuelva antes de continuar
  ///
  /// Args:
  ///   url (String): La url para realizar la solicitud.
  ///   headers (Map<String, String>): Un mapa de encabezados que se enviarán con la solicitud.
  ///
  /// Returns:
  ///   Un futuro<http.Response>
  static Future<http.Response> get(
      {required String url, Map<String, String>? headers}) async {
    return http.get(Uri.parse(url), headers: headers);
  }

  /// Send a POST request
  /// Hace una solicitud POST a la URL dada con los encabezados y el cuerpo dados.
  ///
  /// Args:
  ///   url (String): La url a la que se va a realizar la solicitud.
  ///   headers (Map<String, String>): Un mapa de encabezados que se enviarán con la solicitud.
  ///   body (Map<String, dynamic>): El cuerpo de la solicitud.
  ///
  /// Returns:
  ///   Un futuro<http.Response>
  static Future<http.Response> post(
      {required String url,
      Map<String, String>? headers,
      Map<String, dynamic>? body}) async {
    return http.post(Uri.parse(url), headers: headers, body: json.encode(body));
  }
}
