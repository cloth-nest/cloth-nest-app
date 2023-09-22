import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class KeyNotFoundException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  KeyNotFoundException(this.message, {this.tag = ''});
}
