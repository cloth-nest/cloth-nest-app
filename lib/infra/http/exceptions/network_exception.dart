class NetworkException implements Exception {
  final String message;

  NetworkException({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
