import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/order/order_model.dart';
import 'package:ecommerce/domain/entities/order/order_entity.dart';
import 'package:ecommerce/domain/usecases/order/fetch_order.dart';

class RemoteFetchOrder implements FetchOrder {
  final HttpClient client;
  final String url;

  RemoteFetchOrder({required this.client, required this.url});

  @override
  Future<List<OrderEntity>> call({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse('$url?page=$page&limit=$limit'),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);

      final List<OrderEntity> result = List.from(json['data']['orders'])
          .map((e) => OrderModel.fromMap(e).toEntity())
          .toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
