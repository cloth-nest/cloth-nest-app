import 'package:ecommerce/validation/exceptions/validation_exception.dart';

class EmailValidationException implements ValidationException {
  @override
  final String field;
  @override
  final String message;
  @override
  final String actual;
  @override
  final String expected;

  EmailValidationException({
    required this.field,
    this.message = 'The email is invalid.',
    this.actual = '',
    this.expected = '',
  });

  @override
  String toString() => message;
}
