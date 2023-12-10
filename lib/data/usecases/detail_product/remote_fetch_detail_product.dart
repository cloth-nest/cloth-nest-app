// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/detail_product/detail_product_model.dart';
import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';
import 'package:ecommerce/domain/usecases/detail_product/fetch_detail_product.dart';
import 'package:flutter/foundation.dart';

class RemoteFetchDetailProduct implements FetchDetailProduct {
  final HttpClient client;
  final String url;

  RemoteFetchDetailProduct({
    required this.client,
    required this.url,
  });

  @override
  Future<DetailProductEntity> call({required int idProduct}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse('$url/$idProduct'),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);
      final DetailProductModel model = DetailProductModel.fromMap(json['data']);
      final DetailProductEntity entity = model.toEntity();
      return entity;
    } catch (e) {
      debugPrint('error fetch detail product: $e');
      rethrow;
    }
  }
}
