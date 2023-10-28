import 'package:ecommerce/validation/exceptions/half_width_symbol_validation_exception.dart';
import 'package:ecommerce/validation/exceptions/validation_exception.dart';
import 'package:ecommerce/validation/protocols/field_validation.dart';
import 'package:equatable/equatable.dart';

class HalfWidthSymbolValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const HalfWidthSymbolValidation(this.field) : super();

  @override
  ValidationException? validate(Map input) {
    // regex character full-width and character space
    final regex =
        RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$');
    final isValid = regex.hasMatch(input[field]);
    return isValid ? null : HalfWidthSymbolValidationException(field: field);
  }
}
