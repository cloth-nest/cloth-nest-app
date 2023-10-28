import 'package:ecommerce/data/cache/delete_secure_cache_storage.dart';
import 'package:ecommerce/domain/usecases/token/delete_token.dart';

class LocalDeleteToken implements DeleteToken {
  final String boxKey;
  final String encryptionKey;
  final DeleteSecureCacheStorage deleteSecureCacheStorage;

  LocalDeleteToken({
    required this.boxKey,
    required this.encryptionKey,
    required this.deleteSecureCacheStorage,
  });

  @override
  Future<void> call({required String key}) async {
    try {
      await deleteSecureCacheStorage.deleteByKey(
        encryptionKey: encryptionKey,
        boxKey: boxKey,
        key: key,
      );
    } catch (e) {
      throw Exception('Delete token failed');
    }
  }
}
