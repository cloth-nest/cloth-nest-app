import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (kDebugMode) {
      debugPrint(
          '┌───────────────── Start Request ───────────────────────────');
      debugPrint('│ Uri : ${request.url}');
      debugPrint('│ Method : ${request.method.toUpperCase()}');
    }
    final String header = jsonEncode(request.headers);
    if (kDebugMode) {
      debugPrint('│ Headers : $header');
    }
    // Body
    if (request is Request) {
      final body = request.body;
      if (body.isNotEmpty && kDebugMode) {
        debugPrint('| Body data $body');
      }
    }
    if (kDebugMode) {
      debugPrint('└───────────────── End Request ───────────────────────────');
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    try {
      if (response.statusCode == 201 || response.statusCode == 200) {
        if (kDebugMode) {
          debugPrint('┌───────────────── Response ───────────────────────────');
          debugPrint('│ Uri : ${response.request?.url}');
          debugPrint('│ Method : ${response.request?.method.toUpperCase()}');
          debugPrint('│ Status Code : ${response.statusCode}');
        }

        if (response is Response) {
          final body = response.body;
          if (body.isNotEmpty && kDebugMode) {
            debugPrint('| Response $body');
          }
        } else if (response is StreamedResponse) {
          final parsedResponse = await Response.fromStream(response);
          final body = parsedResponse.body;
          if (body.isNotEmpty && kDebugMode) {
            debugPrint('| Response $body');
          }
        }
        if (kDebugMode) {
          debugPrint(
              '└───────────────── End Response ───────────────────────────');
        }
      } else {
        if (kDebugMode) {
          _printError(response);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return response;
  }

  void _printError(BaseResponse response) async {
    debugPrint('┌───────────────── Response Error ───────────────────────────');
    debugPrint('│ Uri : ${response.request?.url}');
    debugPrint('│ Header : ${response.request?.headers}');
    debugPrint('│ Method : ${response.request?.method.toUpperCase()}');
    debugPrint('│ Status Code : ${response.statusCode}');
    if (response is StreamedResponse) {
      final parsedResponse = await Response.fromStream(response);
      final body = parsedResponse.body;
      if (body.isNotEmpty) {
        debugPrint('| Error Response $body');
      }
    } else if (response is Response) {
      final body = response.body;
      if (body.isNotEmpty) {
        debugPrint('| Error Response $body');
      }
    }
    debugPrint(
        '└───────────────── End Response Error ───────────────────────────');
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }
}
