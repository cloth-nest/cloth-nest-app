import 'package:ecommerce/validation/exceptions/email_validation_exception.dart';
import 'package:ecommerce/validation/exceptions/validation_exception.dart';
import 'package:ecommerce/validation/protocols/field_validation.dart';
import 'package:equatable/equatable.dart';

class EmailValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const EmailValidation(this.field) : super();

  @override
  ValidationException? validate(Map input) {
    final regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid =
        input[field]?.isNotEmpty != true || regex.hasMatch(input[field]);
    return isValid ? null : EmailValidationException(field: field);
  }
}
