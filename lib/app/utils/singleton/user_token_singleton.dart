import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';

class UserTokenSingleton {
  // Private constructor
  UserTokenSingleton._privateConstructor();

  // Static instance
  static final UserTokenSingleton _instance =
      UserTokenSingleton._privateConstructor();

  // Factory method to return the same instance
  factory UserTokenSingleton() {
    return _instance;
  }

  // Variable to store the latest user session
  TokenEntity? _latestUserToken;

  // Method to get the latest user session
  TokenEntity? get latestUserSession => _latestUserToken;

  void updateLatestUserToken(dynamic newToken) {
    if (newToken == null) {
      _latestUserToken = null;
    } else if (newToken is TokenModel) {
      _latestUserToken = newToken.toEntity();
    } else if (newToken is TokenEntity) {
      _latestUserToken = newToken;
    } else {
      throw ArgumentError(
          'newSession must be of type UserSessionEntity or UserSessionModel');
    }
  }
}
