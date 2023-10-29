import 'package:ecommerce/data/cache/save_secure_cache_storage.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/token/save_token.dart';

class LocalSaveToken implements SaveToken {
  final String boxKey;
  final String encryptionKey;
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveToken({
    required this.boxKey,
    required this.encryptionKey,
    required this.saveSecureCacheStorage,
  });

  @override
  Future<void> call({required TokenEntity tokenEntity}) async {
    final tokenModel = tokenEntity.toModel();
    try {
      await saveSecureCacheStorage.put(
        encryptionKey: encryptionKey,
        boxKey: boxKey,
        key: tokenModel.userModel.mail,
        value: tokenModel,
      );
    } catch (e) {
      throw Exception('Failed to save local token');
    }
  }
}
