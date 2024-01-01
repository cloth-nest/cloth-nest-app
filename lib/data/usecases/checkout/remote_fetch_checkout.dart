// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/usecases/checkout/fetch_checkout.dart';

class RemoteFetchCheckOut implements FetchCheckOut {
  final HttpClient client;
  final String url;

  RemoteFetchCheckOut({
    required this.client,
    required this.url,
  });

  @override
  Future<OrderEntity> checkOutFromCart({
    required int addressId,
    required String phone,
    required String paymentMethod,
    required int ghnServerTypeId,
  }) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: {
          'addressId': addressId,
          'ghnServerTypeId': ghnServerTypeId,
          'phone': phone,
          'paymentMethod': paymentMethod,
        },
      );
      final json = ResponseHandler.handle(response);
      final OrderModel model = OrderModel.fromMap(json['data']['order']);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrderEntity> checkOutNow({
    required int addressId,
    required String phone,
    required String paymentMethod,
    required int ghnServerTypeId,
    required int variantId,
    required int quantity,
  }) async {
    try {
      final response = await client
          .makeRequest(uri: Uri.parse(url), method: HttpMethod.post, body: {
        'addressId': addressId,
        'ghnServerTypeId': ghnServerTypeId,
        'phone': phone,
        'paymentMethod': paymentMethod,
        'variantId': variantId,
        'quantity': quantity,
      });
      final json = ResponseHandler.handle(response);
      final OrderModel model = OrderModel.fromMap(json['data']['order']);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
