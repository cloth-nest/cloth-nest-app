import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class FilterCacheException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  FilterCacheException(this.message, {this.tag = ''});
}
