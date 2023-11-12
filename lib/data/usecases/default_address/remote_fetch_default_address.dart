import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/default_address/fetch_default_address.dart';

class RemoteFetchDefaultAddress implements FetchDefaultAddress {
  final HttpClient client;
  final String url;

  RemoteFetchDefaultAddress({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required int id}) async {
    try {
      final httpResponse = await client.makeRequest(
        uri: Uri.parse('$url/$id'),
        method: HttpMethod.patch,
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
