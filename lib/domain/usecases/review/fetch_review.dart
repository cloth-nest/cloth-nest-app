import 'package:ecommerce/domain/entities/review/review_entity.dart';

abstract class FetchReviews {
  Future<List<ReviewEntity>> call({
    required int idProduct,
  });
}
