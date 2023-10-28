import 'package:ecommerce/domain/usecases/authentication/forget_password/forget_password_params.dart';

abstract class FetchForgetPassword {
  Future<void> call({required ForgetPasswordParams params});
}
