// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/recommendation_product/fetch_recommendation_product.dart';
import 'package:flutter/material.dart';

class RemoteFetchRecommendationProduct implements FetchRecommendationProduct {
  final HttpClient client;
  final String url;

  RemoteFetchRecommendationProduct({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ProductEntity>> call({required int idProduct}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse('$url/$idProduct?count=20'),
        method: HttpMethod.get,
      );

      final json = ResponseHandler.handle(response);
      final List<ProductEntity> products = List.from(json['data'])
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList();
      return products;
    } catch (e) {
      debugPrint('error fetch recommendation product: $e');
      rethrow;
    }
  }
}
