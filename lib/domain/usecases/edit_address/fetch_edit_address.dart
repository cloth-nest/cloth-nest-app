import 'package:ecommerce/domain/usecases/edit_address/edit_address_params.dart';

abstract class FetchCreateAddress {
  Future<void> call({required EditAddressParams params});
}
