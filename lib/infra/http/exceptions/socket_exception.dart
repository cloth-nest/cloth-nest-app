class SocketException implements Exception {
  final String message;

  SocketException({
    required this.message,
  });

  @override
  String toString() {
    return message;
  }
}
