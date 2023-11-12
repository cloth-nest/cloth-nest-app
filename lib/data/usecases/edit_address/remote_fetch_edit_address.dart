import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/address/address_model.dart';
import 'package:ecommerce/data/usecases/edit_address/remote_edit_address_params.dart';
import 'package:ecommerce/domain/entities/address/address_entity.dart';
import 'package:ecommerce/domain/usecases/edit_address/edit_address_params.dart';
import 'package:ecommerce/domain/usecases/edit_address/fetch_edit_address.dart';

class RemoteFetchEditAddress implements FetchEditAddress {
  final HttpClient client;
  final String url;

  RemoteFetchEditAddress({
    required this.client,
    required this.url,
  });

  @override
  Future<AddressEntity> call({required EditAddressParams params}) async {
    final RemoteEditAddressParams editAddressParams =
        RemoteEditAddressParams.fromDomain(params);

    try {
      final httpResponse = await client.makeRequest(
        uri: Uri.parse('$url/${editAddressParams.id}'),
        method: HttpMethod.patch,
        body: editAddressParams.toJson(),
      );
      final json = ResponseHandler.handle(httpResponse);
      AddressEntity entity = AddressModel.fromMap(json['data']).toEntity();
      return entity;
    } catch (e) {
      rethrow;
    }
  }
}
