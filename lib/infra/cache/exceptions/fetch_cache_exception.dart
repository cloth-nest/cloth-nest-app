import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class FetchCacheException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  FetchCacheException(this.message, {this.tag = ''});
}
