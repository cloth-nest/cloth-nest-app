import 'dart:convert';

import 'package:ecommerce/data/http/exceptions/bad_request_exception.dart';
import 'package:ecommerce/data/http/exceptions/forbiden_exception.dart';
import 'package:ecommerce/data/http/exceptions/internal_server_exception.dart';
import 'package:ecommerce/data/http/exceptions/not_found_exception.dart';
import 'package:ecommerce/data/http/exceptions/unauthorized_exception.dart';
import 'package:ecommerce/data/models/http_exception_model.dart';
import 'package:http/http.dart';

/*
200			Success																
204			No Content																
400			BadRequest																
401			Unauthorized																
403			Forbidden																
404			NotFound																
500			Internal server error																
 */

class ResponseHandler {
  static dynamic handle<T>(Response httpResponse) {
    switch (httpResponse.statusCode) {
      case 201:
        final jsonBody = jsonDecode(httpResponse.body);
        return jsonBody;
      case 204:
        return;
      default:
        throw _createExceptionFormResponse(httpResponse);
    }
  }

  static _createExceptionFormResponse(Response httpResponse) {
    final jsonBody = jsonDecode(httpResponse.body);
    final httpException = HttpExceptionModel.fromJson(jsonBody);

    return _createExceptionFromStatusCode(
      statusCode: httpResponse.statusCode,
      httpException: httpException,
    );
  }

  static _createExceptionFromStatusCode({
    required int statusCode,
    required HttpExceptionModel httpException,
  }) {
    final code = httpException.code;
    final message = httpException.message;

    switch (statusCode) {
      case 400:
        throw BadRequestException(code: code, message: message);
      case 401:
        throw UnauthorizedException(code: code, message: message);
      case 403:
        throw ForbidenException(code: code, message: message);
      case 404:
        throw NotFoundException(code: code, message: message);
      case 500:
        throw InternalServerException(code: code, message: message);
    }
  }
}
