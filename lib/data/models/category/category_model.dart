// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/category/category_entity.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? bgImgUrl;

  final List<CategoryModel> subCategory;

  CategoryModel({
    required this.id,
    required this.name,
    this.bgImgUrl,
    required this.subCategory,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'] as String,
      subCategory: List<CategoryModel>.from(
        (map['childs']).map<CategoryModel>(
          (x) => CategoryModel.fromMap(x),
        ),
      ),
      bgImgUrl: map['bgImgUrl'],
    );
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        subCategory: List<CategoryModel>.from(subCategory)
            .map((e) => e.toEntity())
            .toList(),
      );
}
