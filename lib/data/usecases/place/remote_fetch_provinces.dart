import 'dart:convert';

import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/place/place_model.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:ecommerce/domain/usecases/place/fetch_provinces.dart';

class RemoteFetchProvinces implements FetchProvinces {
  final HttpClient client;
  final String url;

  const RemoteFetchProvinces({
    required this.client,
    required this.url,
  });

  @override
  Future<List<PlaceEntity>> call() async {
    try {
      final httpResponse = await client.get(
        Uri.parse(url),
      );
      final List<dynamic> json =
          jsonDecode(utf8.decode(httpResponse.bodyBytes));
      final List<PlaceEntity> result = json.map((e) {
        return PlaceModel.fromMap(e).toEntity();
      }).toList();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
