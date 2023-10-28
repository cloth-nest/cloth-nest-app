import 'package:ecommerce/validation/exceptions/validation_exception.dart';

class SpecialCharacterValidationException implements ValidationException {
  @override
  final String field;
  @override
  final String message;
  @override
  final String actual;
  @override
  final String expected;

  SpecialCharacterValidationException({
    required this.field,
    this.message = 'The special character is invalid.',
    this.actual = '',
    this.expected = '',
  });

  @override
  String toString() => message;
}
