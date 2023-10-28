import 'package:ecommerce/validation/exceptions/validation_exception.dart';

class HalfWidthSymbolValidationException implements ValidationException {
  @override
  final String field;
  @override
  final String message;
  @override
  final String actual;
  @override
  final String expected;

  HalfWidthSymbolValidationException({
    required this.field,
    this.message = 'The Character type is invalid.',
    this.actual = '',
    this.expected = '',
  });

  @override
  String toString() => message;
}
