// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/exceptions/http_exception.dart';
import 'package:ecommerce/data/exceptions/missing_param_exception.dart';

class HttpExceptionModel implements HttpException {
  @override
  final String code;

  @override
  final String message;

  HttpExceptionModel({
    required this.code,
    required this.message,
  });

  factory HttpExceptionModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('code') || !json.containsKey('message')) {
      throw MissingParamException(
          'HttpExceptionModel: missing parameters code or message');
    }

    return HttpExceptionModel(
      code: json['code'],
      message: json['message'],
    );
  }
}
