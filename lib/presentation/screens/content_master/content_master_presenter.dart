import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:flutter/foundation.dart';

abstract class ContentMasterPresenter implements ChangeNotifier {
  Future<void> fetchMasterCategory();

  List<CategoryEntity> get topCategories;

  List<CategoryEntity> get searchCategories;
}
