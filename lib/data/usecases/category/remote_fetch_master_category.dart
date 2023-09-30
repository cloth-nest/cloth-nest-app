// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/app/mocks/mock_category.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/category/master_category_model.dart';
import 'package:ecommerce/domain/entities/category/master_category_entity.dart';
import 'package:ecommerce/domain/usecases/category/fetch_master_category.dart';

class RemoteFetchMasterCategory implements FetchMasterCategory {
  final HttpClient httpClient;
  final String url;

  RemoteFetchMasterCategory({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<MasterCategoryEntity> call() async {
    try {
      // final response = await httpClient.makeRequest(
      //   uri: Uri.parse(url),
      //   method: HttpMethod.get,
      // );
      final response = bodyCategoryMock;
      final MasterCategoryModel model = MasterCategoryModel.fromMap(response);
      final MasterCategoryEntity entity = model.toEntity();
      return entity;
    } catch (e) {
      rethrow;
    }
  }
}
