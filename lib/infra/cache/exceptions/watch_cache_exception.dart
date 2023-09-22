import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class WatchCacheException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  WatchCacheException(this.message, {this.tag = ''});
}
