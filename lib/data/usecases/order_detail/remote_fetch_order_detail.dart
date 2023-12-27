// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/usecases/order_detail/fetch_order_detail.dart';

class RemoteFetchOrderDetail implements FetchOrderDetail {
  final HttpClient client;
  final String url;
  RemoteFetchOrderDetail({
    required this.client,
    required this.url,
  });

  @override
  Future<OrderEntity> call({required int idOrder}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse('$url/$idOrder'),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);
      return OrderModel.fromMap(json['data']['order']).toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
