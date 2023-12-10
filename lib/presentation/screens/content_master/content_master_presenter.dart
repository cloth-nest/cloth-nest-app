import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/domain/entities/product_type/product_type_entity.dart';
import 'package:flutter/foundation.dart';

abstract class ContentMasterPresenter implements ChangeNotifier {
  Future<void> fetchCategories();
  Future<void> fetchProductTypes();

  List<CategoryEntity> get rootCategories;
  Map<String, dynamic> get secondCategories;
  List<ProductTypeEntity> get productTypes;
}
