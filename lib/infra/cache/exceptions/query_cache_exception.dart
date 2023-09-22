import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class QueryCacheException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  QueryCacheException(this.message, {this.tag = ''});
}
