import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/create_address/remote_create_address_params.dart';
import 'package:ecommerce/domain/usecases/create_address/create_address_params.dart';
import 'package:ecommerce/domain/usecases/create_address/fetch_create_address.dart';

class RemoteFetchCreateAddress implements FetchCreateAddress {
  final HttpClient client;
  final String url;

  RemoteFetchCreateAddress({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required CreateAddressParams params}) async {
    final RemoteCreateAddressParams createAddressParams =
        RemoteCreateAddressParams.fromDomain(params);

    try {
      final httpResponse = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: createAddressParams.toJson(),
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
