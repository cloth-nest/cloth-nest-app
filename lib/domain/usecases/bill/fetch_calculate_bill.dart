import 'package:ecommerce/domain/entities/bill/bill_entity.dart';

abstract class FetchCalculateBill {
  Future<BillEntity> call({
    required int addressId,
    required int ghnServerTypeId,
    Map<String, dynamic>? carts,
  });
}
