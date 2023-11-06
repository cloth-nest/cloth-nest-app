import 'package:ecommerce/domain/usecases/create_address/create_address_params.dart';

abstract class FetchCreateAddress {
  Future<void> call({required CreateAddressParams params});
}
