import 'package:ecommerce/validation/exceptions/validation_exception.dart';
import 'package:ecommerce/validation/protocols/field_validation.dart';
import 'package:equatable/equatable.dart';

import '../exceptions/required_validation_exception.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidation(this.field);

  @override
  ValidationException? validate(Map input) => input[field]?.isNotEmpty == true
      ? null
      : RequiredValidationException(field: field);
}
