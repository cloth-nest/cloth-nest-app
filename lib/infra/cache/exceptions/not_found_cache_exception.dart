import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class NotFoundCacheException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  NotFoundCacheException(this.message, {this.tag = ''});
}
