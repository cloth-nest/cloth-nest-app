import 'package:ecommerce/validation/exceptions/length_validation_exception.dart';
import 'package:ecommerce/validation/exceptions/validation_exception.dart';
import 'package:ecommerce/validation/protocols/field_validation.dart';
import 'package:equatable/equatable.dart';

class LengthValidation extends Equatable implements FieldValidation {
  @override
  final String field;
  final int maxLength;
  final int minLength;

  @override
  List get props => [field];

  const LengthValidation(this.field, this.minLength, this.maxLength) : super();

  @override
  ValidationException? validate(Map input) {
    final isValid =
        input[field].length > minLength && input[field].length < maxLength;
    return isValid ? null : LengthValidationException(field: field);
  }
}
