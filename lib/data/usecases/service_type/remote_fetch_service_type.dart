// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/service_type/service_type_model.dart';
import 'package:ecommerce/domain/entities/service_type/service_type_entity.dart';
import 'package:ecommerce/domain/usecases/service_type/fetch_service_type.dart';

class RemoteFetchServiceType implements FetchServiceType {
  final HttpClient client;
  final String url;
  RemoteFetchServiceType({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ServiceTypeEntity>> call({required int toDistrict}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: {
          "shop_id": 4772398,
          "from_district": 3695,
          "to_district": toDistrict,
        },
        headers: {
          'token': 'c380eebe-d0f8-11ed-a3ed-eac62dba9bd9',
        },
      );

      final json = ResponseHandler.handle(response);

      final List<ServiceTypeEntity> results = List.from(json['data'])
          .map((e) => ServiceTypeModel.fromMap(e).toEntity())
          .toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
