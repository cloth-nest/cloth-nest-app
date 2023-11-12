import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/delete_address/fetch_delete_address.dart';

class RemoteFetchDeleteAddress implements FetchDeleteAddress {
  final HttpClient client;
  final String url;

  const RemoteFetchDeleteAddress({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required int id}) async {
    try {
      final httpResponse = await client.makeRequest(
        uri: Uri.parse('$url/$id'),
        method: HttpMethod.delete,
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
