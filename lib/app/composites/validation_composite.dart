import 'package:ecommerce/presentation/protocols/validation.dart';
import 'package:ecommerce/validation/protocols/field_validation.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  List<Exception> validate({required String field, required Map input}) {
    List<Exception> errors = [];
    for (final validation in validations.where((v) => v.field == field)) {
      final error = validation.validate(input);
      if (error != null) {
        errors.add(error);
      }
    }
    return errors;
  }
}
