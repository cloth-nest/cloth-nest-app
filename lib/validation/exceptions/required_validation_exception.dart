import 'package:ecommerce/validation/exceptions/validation_exception.dart';

class RequiredValidationException implements ValidationException {
  @override
  final String field;
  @override
  final String message;
  @override
  final String actual;
  @override
  final String expected;

  RequiredValidationException({
    required this.field,
    this.message = 'The field is required.',
    this.actual = '',
    this.expected = '',
  });

  @override
  String toString() => message;
}
