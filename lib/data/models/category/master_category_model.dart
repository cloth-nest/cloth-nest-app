// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/category/category_model.dart';
import 'package:ecommerce/domain/entities/category/master_category_entity.dart';

class MasterCategoryModel {
  final List<CategoryModel> search;
  final List<CategoryModel> top;

  MasterCategoryModel({
    required this.search,
    required this.top,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'search': search.map((x) => x.toMap()).toList(),
      'top': top.map((x) => x.toMap()).toList(),
    };
  }

  factory MasterCategoryModel.fromMap(Map<String, dynamic> map) {
    return MasterCategoryModel(
      search: List<CategoryModel>.from(
        (map['search']).map<CategoryModel>(
          (x) => CategoryModel.fromMap(x),
        ),
      ),
      top: List<CategoryModel>.from(
        (map['top']).map<CategoryModel>(
          (x) => CategoryModel.fromMap(x),
        ),
      ),
    );
  }

  MasterCategoryEntity toEntity() => MasterCategoryEntity(
        search:
            List<CategoryModel>.from(search).map((e) => e.toEntity()).toList(),
        top: List<CategoryModel>.from(top).map((e) => e.toEntity()).toList(),
      );
}
