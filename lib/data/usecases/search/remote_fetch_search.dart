import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/search/fetch_search.dart';

class RemoteFetchSearch implements FetchSearch {
  final String url;
  final HttpClient client;

  RemoteFetchSearch({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ProductEntity>> call({
    required String search,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse('$url?search=$search&page=$page&limit=$limit'),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);
      final List<ProductEntity> products = List.from(json['data']['products'])
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }
}
