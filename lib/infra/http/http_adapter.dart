import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/infra/http/constants/constant.dart';
import 'package:ecommerce/infra/http/exceptions/exceptions.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:http/http.dart' as http;

class HttpAdapter implements HttpClient {
  final http.Client _client;

  HttpAdapter(this._client);

  @override
  Future<http.Response> get(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await _client.get(uri, headers: headers);
      return response;
    } on NetworkException catch (e) {
      throw NetworkException(message: e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(message: e.message);
    } on SocketException catch (e) {
      throw SocketException(message: e.message);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<http.Response> makeRequest({
    required Uri uri,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final request = http.Request(
      EnumToString.convertToString(method),
      uri,
    );

    // Add default and custom headers to the request.
    _mergeHeaders(request.headers, headers);

    if (body != null) {
      request.body = jsonEncode(body);
    }

    switch (EnumToString.convertToString(method).toLowerCase()) {
      case 'get':
        return get(
          uri,
          headers: headers,
        );
      case 'post':
        return post(
          request.url,
          headers: request.headers,
          body: request.body,
        );
      case 'delete':
        return delete(
          request.url,
          headers: request.headers,
          body: request.body,
        );
      case 'patch':
        return patch(
          request.url,
          headers: request.headers,
          body: request.body,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<http.Response> post(
    Uri uri, {
    Map<String, String>? headers,
    String? body,
  }) async {
    try {
      final response = await _client.post(
        uri,
        headers: headers,
        body: body,
      );
      return response;
    } on NetworkException catch (e) {
      throw NetworkException(message: e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(message: e.message);
    } on SocketException catch (e) {
      throw SocketException(message: e.message);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  void _mergeHeaders(Map<String, String> requestHeaders,
      [Map<String, String>? customHeaders]) {
    requestHeaders.addAll(defaultHeaders);

    if (customHeaders != null) {
      requestHeaders.addAll(customHeaders);
    }
  }

  @override
  Future<http.Response> delete(Uri uri,
      {Map<String, String>? headers, String? body}) async {
    try {
      final response = await _client.delete(
        uri,
        headers: headers,
        body: body,
      );
      return response;
    } on NetworkException catch (e) {
      throw NetworkException(message: e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(message: e.message);
    } on SocketException catch (e) {
      throw SocketException(message: e.message);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<http.Response> patch(Uri uri,
      {Map<String, String>? headers, String? body}) async {
    try {
      final response = await _client.patch(
        uri,
        headers: headers,
        body: body,
      );
      return response;
    } on NetworkException catch (e) {
      throw NetworkException(message: e.message);
    } on TimeoutException catch (e) {
      throw TimeoutException(message: e.message);
    } on SocketException catch (e) {
      throw SocketException(message: e.message);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }
}
