abstract class ValidationException implements Exception {
  String get field;
  String get message;
  dynamic get expected;
  dynamic get actual;
}
