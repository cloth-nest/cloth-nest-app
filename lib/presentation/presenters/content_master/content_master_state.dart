// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/category/category_entity.dart';

class ContentMasterState {
  final List<CategoryEntity>? categories;
  final Map<String, dynamic>? secondCategories;

  ContentMasterState({
    required this.categories,
    required this.secondCategories,
  });

  ContentMasterState copyWith({
    List<CategoryEntity>? categories,
    Map<String, dynamic>? secondCategories,
  }) {
    return ContentMasterState(
      categories: categories ?? this.categories,
      secondCategories: secondCategories ?? this.secondCategories,
    );
  }

  factory ContentMasterState.initial() {
    return ContentMasterState(categories: null, secondCategories: null);
  }
}
