import 'package:ecommerce/validation/exceptions/validation_exception.dart';

abstract class FieldValidation {
  String get field;
  ValidationException? validate(Map input);
}
