// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/http/exceptions/http_exception.dart';

class BadRequestException implements HttpException {
  @override
  final String code;

  @override
  final String message;

  BadRequestException({
    required this.code,
    required this.message,
  });
}
