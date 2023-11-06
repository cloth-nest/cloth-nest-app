import 'package:ecommerce/domain/usecases/edit_address/edit_address_params.dart';

abstract class FetchEditAddress {
  Future<void> call({required EditAddressParams params});
}
