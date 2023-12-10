// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/domain/entities/product_type/product_type_entity.dart';

class ContentMasterState {
  final List<CategoryEntity>? categories;
  final Map<String, dynamic>? secondCategories;
  final List<ProductTypeEntity> productTypes;

  ContentMasterState({
    required this.categories,
    required this.secondCategories,
    required this.productTypes,
  });

  ContentMasterState copyWith({
    List<CategoryEntity>? categories,
    Map<String, dynamic>? secondCategories,
    List<ProductTypeEntity>? productTypes,
  }) {
    return ContentMasterState(
      categories: categories ?? this.categories,
      secondCategories: secondCategories ?? this.secondCategories,
      productTypes: productTypes ?? this.productTypes,
    );
  }

  factory ContentMasterState.initial() {
    return ContentMasterState(
      categories: null,
      secondCategories: null,
      productTypes: [],
    );
  }
}
