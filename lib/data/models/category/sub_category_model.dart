// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/category/sub_category_entity.dart';

class SubCategoryModel {
  final String id;
  final String name;
  final String? categoryThumbUrl;

  SubCategoryModel({
    required this.id,
    required this.name,
    this.categoryThumbUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'categoryThumbUrl': categoryThumbUrl,
    };
  }

  factory SubCategoryModel.fromMap(Map<String, dynamic> map) {
    return SubCategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      categoryThumbUrl: map['categoryThumbUrl'] != null
          ? map['categoryThumbUrl'] as String
          : null,
    );
  }

  SubCategoryEntity toEntity() => SubCategoryEntity(
        id: id,
        name: name,
        categoryThumbUrl: categoryThumbUrl,
      );
}
