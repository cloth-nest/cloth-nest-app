import 'package:ecommerce/domain/entities/token/token_entity.dart';

abstract class SaveToken {
  Future<void> call({required TokenEntity tokenEntity});
}
