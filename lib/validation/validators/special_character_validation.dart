import 'package:ecommerce/validation/exceptions/special_character_validation_exception.dart';
import 'package:ecommerce/validation/exceptions/validation_exception.dart';
import 'package:ecommerce/validation/protocols/field_validation.dart';
import 'package:equatable/equatable.dart';

class SpecialCharacterValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const SpecialCharacterValidation(this.field) : super();

  @override
  ValidationException? validate(Map input) {
    // regex character special
    final regex = RegExp(r'[^$*.[]{}()?-"!@#%&/\,><:;_~`+=]');
    final isValid =
        input[field]?.isNotEmpty != true || !regex.hasMatch(input[field]);
    return isValid ? null : SpecialCharacterValidationException(field: field);
  }
}
