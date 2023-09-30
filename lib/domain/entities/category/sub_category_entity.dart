// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/category/sub_category_model.dart';

class SubCategoryEntity {
  final String id;
  final String name;
  final String? categoryThumbUrl;

  SubCategoryEntity({
    required this.id,
    required this.name,
    this.categoryThumbUrl,
  });

  SubCategoryModel toModel() => SubCategoryModel(
        id: id,
        name: name,
      );
}
