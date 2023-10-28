import 'package:ecommerce/validation/exceptions/validation_exception.dart';

class LengthValidationException implements ValidationException {
  @override
  final String field;
  @override
  final String message;
  @override
  final String actual;
  @override
  final String expected;

  LengthValidationException({
    required this.field,
    this.message = 'The length is invalid.',
    this.actual = '',
    this.expected = '',
  });

  @override
  String toString() => message;
}
