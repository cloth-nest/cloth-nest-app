// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/product/product_model.dart';
import 'package:ecommerce/data/usecases/product/remote_fetch_product_params.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product_params.dart';

class RemoteFetchProduct implements FetchProduct {
  final HttpClient client;
  final String url;
  RemoteFetchProduct({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ProductEntity>> call({required FetchProductParams params}) async {
    try {
      RemoteFetchProductParams remoteFetchProductParams =
          RemoteFetchProductParams.fromDomain(params);

      String urlResult = '/${params.idCategory}?';

      for (var key in remoteFetchProductParams.toJson().keys) {
        urlResult += '$key=${remoteFetchProductParams.toJson()[key]}&';
      }

      final response = await client.makeRequest(
        uri: Uri.parse('$url$urlResult'),
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
