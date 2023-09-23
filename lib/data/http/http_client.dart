import 'package:http/http.dart' as http;

enum HttpMethod {
  get,
  post,
  put,
  delete,
  head,
  options,
  patch,
}

abstract class HttpClient {
  Future<http.Response> makeRequest({
    required Uri uri,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  Future<http.Response> get(Uri uri, {Map<String, String>? headers});

  Future<http.Response> post(
    Uri uri, {
    Map<String, String>? headers,
    String? body,
  });
}
