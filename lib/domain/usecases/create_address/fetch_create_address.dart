import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/usecases/create_address/create_address_params.dart';

abstract class FetchCreateAddress {
  Future<AddressEntity> call({required CreateAddressParams params});
}
