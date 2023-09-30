// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/category/sub_category_model.dart';
import 'package:ecommerce/domain/entities/category/category_entity.dart';

class CategoryModel {
  final String id;
  final String name;
  final List<SubCategoryModel> subCategory;

  CategoryModel({
    required this.id,
    required this.name,
    required this.subCategory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subCategory': subCategory.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      subCategory: List<SubCategoryModel>.from(
        (map['sub_category']).map<SubCategoryModel>(
          (x) => SubCategoryModel.fromMap(x),
        ),
      ),
    );
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        subCategory: List<SubCategoryModel>.from(subCategory)
            .map((e) => e.toEntity())
            .toList(),
      );
}
