// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/domain/entities/category/sub_category_entity.dart';

class CategoryEntity {
  final String id;
  final String name;
  final List<SubCategoryEntity> subCategory;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.subCategory,
  });

  CategoryModel toModel() => CategoryModel(
        id: id,
        name: name,
        subCategory: List<SubCategoryEntity>.from(subCategory)
            .map((e) => e.toModel())
            .toList(),
      );
}
