class UnknownException implements Exception {
  final String message;

  UnknownException({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
