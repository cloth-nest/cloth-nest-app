import 'package:ecommerce/domain/entities/user/user_entity.dart';

abstract class FetchProfile {
  Future<UserEntity> call();
}
