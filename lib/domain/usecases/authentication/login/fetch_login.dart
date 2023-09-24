import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/login/login_params.dart';

abstract class FetchLogin {
  Future<TokenEntity> call({required LoginParams loginParams});
}
