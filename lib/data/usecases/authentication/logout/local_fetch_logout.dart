import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/fetch_logout.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/logout_params.dart';
import 'package:ecommerce/domain/usecases/token/delete_token.dart';

class LocalFetchLogout implements FetchLogout {
  final DeleteToken deleteToken;

  LocalFetchLogout({required this.deleteToken});

  @override
  Future<void> call({LogoutParams? params}) async {
    try {
      await Future.wait([
        deleteToken.call(key: uniqueUserTokenKey),
      ]);
    } catch (e) {
      rethrow;
    }
  }
}
