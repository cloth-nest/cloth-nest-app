// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/cancel_order/fetch_cancel_order.dart';

class RemoteFetchCancelOrder implements FetchCancelOrder {
  final HttpClient client;
  final String url;
  RemoteFetchCancelOrder({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required int idOrder}) async {
    try {
      final response = await client.delete(
        Uri.parse('$url/$idOrder'),
      );
      final json = ResponseHandler.handle(response);

      if (json['error'] != null && json['error']['message'] != null) {
        throw json['error']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
