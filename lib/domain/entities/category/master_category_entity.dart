// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/category/master_category_model.dart';
import 'package:ecommerce/domain/entities/category/category_entity.dart';

class MasterCategoryEntity {
  final List<CategoryEntity> search;
  final List<CategoryEntity> top;

  MasterCategoryEntity({
    required this.search,
    required this.top,
  });

  MasterCategoryModel toModel() => MasterCategoryModel(
        search:
            List<CategoryEntity>.from(search).map((e) => e.toModel()).toList(),
        top: List<CategoryEntity>.from(top).map((e) => e.toModel()).toList(),
      );
}
