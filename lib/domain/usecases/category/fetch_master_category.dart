import 'package:ecommerce/domain/entities/category/category_entity.dart';

abstract class FetchCategory {
  Future<List<CategoryEntity>> call();
}
