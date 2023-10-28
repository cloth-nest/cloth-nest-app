import 'package:ecommerce/domain/usecases/authentication/resend_code/resend_code_params.dart';

abstract class FetchResendCode {
  Future<void> call({required ResendCodeParams params});
}
