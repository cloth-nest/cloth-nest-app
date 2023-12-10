// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/domain/usecases/category/fetch_master_category.dart';

class RemoteFetchCategory implements FetchCategory {
  final HttpClient httpClient;
  final String url;

  RemoteFetchCategory({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<List<CategoryEntity>> call() async {
    try {
      final response = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(response);
      List<CategoryEntity> categories = List.from(json['data'])
          .map((e) => CategoryModel.fromMap(e).toEntity())
          .toList();
      return categories;
    } catch (e) {
      rethrow;
    }
  }
}
