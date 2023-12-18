import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/place/place_model.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:ecommerce/domain/usecases/place/fetch_wards.dart';

class RemoteFetchWards implements FetchWards {
  final HttpClient client;
  final String url;

  const RemoteFetchWards({
    required this.client,
    required this.url,
  });

  @override
  Future<List<PlaceEntity>> call({required int code}) async {
    try {
      final httpResponse = await client.makeRequest(
          uri: Uri.parse(url),
          headers: {
            'token': 'c380eebe-d0f8-11ed-a3ed-eac62dba9bd9',
          },
          method: HttpMethod.post,
          body: {
            'district_id': code,
          });
      final json = ResponseHandler.handle(httpResponse);
      final List<PlaceEntity> result = List.from(json['data']).map((e) {
        return PlaceModel.fromMap(e).toEntity();
      }).toList();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
