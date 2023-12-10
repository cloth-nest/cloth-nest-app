// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/product_type/product_type_model.dart';
import 'package:ecommerce/domain/entities/product_type/product_type_entity.dart';
import 'package:ecommerce/domain/usecases/product_type/fetch_product_type.dart';

class RemoteFetchProductType implements FetchProductType {
  final HttpClient client;
  final String url;

  RemoteFetchProductType({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ProductTypeEntity>> call() async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);
      final List<ProductTypeEntity> results =
          List.from(json['data']['productTypes'])
              .map((e) => ProductTypeModel.fromMap(e).toEntity())
              .toList();

      return results;
    } catch (e) {
      rethrow;
    }
  }
}
