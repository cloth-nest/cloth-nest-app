import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/address/address_model.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/usecases/detail_address/fetch_detail_address.dart';

class RemoteFetchDetailAddress implements FetchDetailAddress {
  final HttpClient client;
  final String url;

  RemoteFetchDetailAddress({
    required this.client,
    required this.url,
  });

  @override
  Future<AddressEntity> call({required int id}) async {
    try {
      final httpResponse = await client.makeRequest(
        uri: Uri.parse('$url/$id'),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(httpResponse);
      final AddressEntity entity =
          AddressModel.fromMap(json['data']).toEntity();
      return entity;
    } catch (e) {
      rethrow;
    }
  }
}
