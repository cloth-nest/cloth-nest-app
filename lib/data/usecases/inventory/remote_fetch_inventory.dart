// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/inventory/fetch_inventory.dart';

class RemoteFetchInventory implements FetchInventory {
  final HttpClient client;
  final String url;

  RemoteFetchInventory({
    required this.client,
    required this.url,
  });

  @override
  Future<bool> call() async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);

      return json['data']['isAvailable'];
    } catch (e) {
      rethrow;
    }
  }
}
