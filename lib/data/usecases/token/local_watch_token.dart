import 'package:ecommerce/data/cache/watch_secure_cache_storage.dart';
import 'package:ecommerce/domain/usecases/token/watch_token.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalListenerUserToken implements ListenerUserToken {
  final String _boxKey;
  final WatchSecureCacheStorage _listenerCacheStorage;
  final String _encryptionKey;

  LocalListenerUserToken({
    required String boxKey,
    required WatchSecureCacheStorage listenerCacheStorage,
    required String encryptionKey,
  })  : _boxKey = boxKey,
        _listenerCacheStorage = listenerCacheStorage,
        _encryptionKey = encryptionKey;

  @override
  Future<Stream<BoxEvent>> call(String key) async {
    try {
      final watch = await _listenerCacheStorage.watchByKey(
        boxKey: _boxKey,
        key: key,
        encryptionKey: _encryptionKey,
      );
      return watch;
    } catch (_) {
      throw Exception('Listener user token error');
    }
  }
}
