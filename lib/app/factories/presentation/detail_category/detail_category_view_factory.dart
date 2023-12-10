import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_screen.dart';

DetailCategoryScreen makeDetailCategoryView({
  required String title,
  required List<CategoryEntity> categories,
  required int id,
}) =>
    DetailCategoryScreen(
      title: title,
      categories: categories,
      id: id,
    );
