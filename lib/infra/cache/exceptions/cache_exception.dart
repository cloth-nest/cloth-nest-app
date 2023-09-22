abstract class CacheException implements Exception {
  final String message;

  final String tag;

  CacheException({required this.message, required this.tag});

  @override
  String toString() => '$tag$message';
}
