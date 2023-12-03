import 'package:ecommerce/domain/usecases/update_profile/update_profile_params.dart';

abstract class FetchUpdateProfile {
  Future<void> call({required UpdateProfileParams params});
}
