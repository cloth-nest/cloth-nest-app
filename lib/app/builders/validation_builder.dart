import 'package:ecommerce/validation/protocols/field_validation.dart';
import 'package:ecommerce/validation/validators/email_validation.dart';
import 'package:ecommerce/validation/validators/half_width_symbol_validation.dart';
import 'package:ecommerce/validation/validators/length_validation.dart';
import 'package:ecommerce/validation/validators/required_field_validation.dart';

class ValidationBuilder {
  static ValidationBuilder? _instance;

  String fieldName;
  List<FieldValidation> validations = [];
  ValidationBuilder._(this.fieldName);

  static ValidationBuilder field(String fieldName) {
    _instance = ValidationBuilder._(fieldName);
    return _instance!;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  ValidationBuilder length(int minLength, int maxLength) {
    validations.add(LengthValidation(fieldName, minLength, maxLength));
    return this;
  }

  ValidationBuilder halfWidthSymbol() {
    validations.add(HalfWidthSymbolValidation(fieldName));
    return this;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;
}
