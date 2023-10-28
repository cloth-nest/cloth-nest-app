import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/verify_email/verify_email_params.dart';

abstract class FetchVerifyEmail {
  Future<TokenEntity> call({required VerifyEmailParams params});
}
