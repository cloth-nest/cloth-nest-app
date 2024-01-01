import 'package:ecommerce/presentation/screens/detail_category/detail_category_screen.dart';

DetailCategoryScreen makeDetailCategoryView({
  required String title,
  required int id,
}) =>
    DetailCategoryScreen(
      title: title,
      id: id,
    );
