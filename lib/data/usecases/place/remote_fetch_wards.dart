import 'dart:convert';

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
      final httpResponse = await client.get(
        Uri.parse('$url/$code?depth=2'),
      );
      final json = jsonDecode(utf8.decode(httpResponse.bodyBytes));
      final List<PlaceEntity> result = json['wards'].map<PlaceEntity>((e) {
        return PlaceModel.fromMap(e).toEntity();
      }).toList();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
