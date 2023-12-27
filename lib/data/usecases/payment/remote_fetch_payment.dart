import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/payment/payment_result_model.dart';
import 'package:ecommerce/domain/entities/payment/payment_result_entity.dart';
import 'package:ecommerce/domain/usecases/payment/fetch_payment.dart';

class RemoteFetchPayment implements FetchPayment {
  final HttpClient client;
  final String url;

  const RemoteFetchPayment({
    required this.client,
    required this.url,
  });

  @override
  Future<PaymentResultEntity> call({required int orderId}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse('$url/$orderId'),
        method: HttpMethod.post,
      );
      final json = ResponseHandler.handle(response);
      final PaymentResultModel model =
          PaymentResultModel.fromMap(json['data']['paymentResult']);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
