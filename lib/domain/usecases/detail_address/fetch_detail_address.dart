import 'package:ecommerce/domain/entities/address/address_entity.dart';

abstract class FetchDetailAddress {
  Future<AddressEntity> call({required int id});
}
