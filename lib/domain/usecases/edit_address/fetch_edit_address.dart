import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/usecases/edit_address/edit_address_params.dart';

abstract class FetchEditAddress {
  Future<AddressEntity> call({required EditAddressParams params});
}
