// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/address/address_model.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/usecases/fetch_address/fetch_address.dart';

class RemoteFetchAddress implements FetchAddress {
  final HttpClient client;
  final String url;

  RemoteFetchAddress({
    required this.client,
    required this.url,
  });

  @override
  Future<List<AddressEntity>> call() async {
    try {
      final httpResponse = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(httpResponse);
      final List<AddressEntity> result = json['data']
          .map<AddressEntity>((e) => AddressModel.fromMap(e).toEntity())
          .toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
