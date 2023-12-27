import 'package:ecommerce/domain/entities/payment/payment_result_entity.dart';

abstract class FetchPayment {
  Future<PaymentResultEntity> call({required int orderId});
}
