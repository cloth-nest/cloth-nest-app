// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/review/review_model.dart';
import 'package:ecommerce/domain/entities/review/review_entity.dart';
import 'package:ecommerce/domain/usecases/review/fetch_review.dart';

class RemoteFetchReviews implements FetchReviews {
  final HttpClient client;
  final String url;
  RemoteFetchReviews({
    required this.client,
    required this.url,
  });

  @override
  Future<List<ReviewEntity>> call({required int idProduct}) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse('$url/$idProduct?page=1&limit=0'),
        method: HttpMethod.get,
      );

      final json = ResponseHandler.handle(response);

      return (json['data']['reviews'] as List)
          .map((e) => ReviewModel.fromMap(e).toEntity())
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
