import 'package:ecommerce/domain/usecases/authentication/reset_password/reset_password_params.dart';

abstract class FetchResetPassword {
  Future<void> call({required ResetPasswordParams params});
}
