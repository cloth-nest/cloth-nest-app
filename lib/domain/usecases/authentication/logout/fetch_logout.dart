import 'package:ecommerce/domain/usecases/authentication/logout/logout_params.dart';

abstract class FetchLogout {
  Future<void> call({LogoutParams? params});
}
