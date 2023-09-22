import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class SaveCacheException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  SaveCacheException(this.message, {this.tag = ''});
}
