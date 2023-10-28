import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/auto_login/auto_login_params.dart';

abstract class FetchAutoLogin {
  Future<TokenEntity> call({required AutoLoginParams params});
}
