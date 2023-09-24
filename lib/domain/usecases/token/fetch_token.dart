import 'package:ecommerce/domain/entities/token/token_entity.dart';

abstract class FetchToken {
  Future<TokenEntity?> call({required String key});
}
