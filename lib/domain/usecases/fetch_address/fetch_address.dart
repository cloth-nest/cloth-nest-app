import 'package:ecommerce/domain/entities/address/address_entity.dart';

abstract class FetchAddress {
  Future<List<AddressEntity>> call();
}
