import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:flutter/foundation.dart';

abstract class ContentMasterPresenter implements ChangeNotifier {
  Future<void> fetchCategories();

  List<CategoryEntity> get rootCategories;
  Map<String, dynamic> get secondCategories;
}
