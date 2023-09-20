// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/exceptions/http_exception.dart';

class UnauthorizedException implements HttpException {
  @override
  final String code;

  @override
  final String message;

  UnauthorizedException({
    required this.code,
    required this.message,
  });
}
