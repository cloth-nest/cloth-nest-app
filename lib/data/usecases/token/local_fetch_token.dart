import 'package:ecommerce/data/cache/fetch_secure_cache_storage.dart';
import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';

class LocalFetchToken implements FetchToken {
  final String boxKey;
  final String encryptionKey;
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalFetchToken({
    required this.boxKey,
    required this.encryptionKey,
    required this.fetchSecureCacheStorage,
  });

  @override
  Future<TokenEntity?> call({required String key}) async {
    try {
      final tokenModel = await fetchSecureCacheStorage.fetchByKey(
        encryptionKey: encryptionKey,
        boxKey: boxKey,
        key: key,
      );

      if (tokenModel is TokenModel) {
        return tokenModel.toEntity();
      }

      return null;
    } catch (e) {
      throw Exception('Fetch token failed');
    }
  }
}
