import 'package:ecommerce/domain/usecases/authentication/sign_up/sign_up_params.dart';

abstract class FetchSignUp {
  Future<void> call({required SignUpParams params});
}
