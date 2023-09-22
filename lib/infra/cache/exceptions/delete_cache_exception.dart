import 'package:ecommerce/infra/cache/exceptions/cache_exception.dart';

class DeleteCacheException implements CacheException {
  @override
  final String message;

  @override
  final String tag;

  DeleteCacheException(this.message, {this.tag = ''});
}
