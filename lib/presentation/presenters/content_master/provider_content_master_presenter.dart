import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/domain/usecases/category/fetch_master_category.dart';
import 'package:ecommerce/presentation/presenters/content_master/content_master_state.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:flutter/widgets.dart';

class ProviderContentMasterPresenter
    with ChangeNotifier
    implements ContentMasterPresenter {
  final FetchCategory _fetchCategory;

  ContentMasterState _state = ContentMasterState.initial();

  ProviderContentMasterPresenter({
    required FetchCategory fetchCategory,
  }) : _fetchCategory = fetchCategory;

  Map<String, dynamic> secondCategoriesTmp = {};

  @override
  Future<void> fetchCategories() async {
    try {
      final categories = await _fetchCategory.call();

      for (var rootCategory in categories) {
        for (var firstCategory in rootCategory.subCategory) {
          secondCategoriesTmp['${firstCategory.id}'] =
              firstCategory.subCategory;
        }
      }

      _state = _state.copyWith(
        secondCategories: secondCategoriesTmp,
        categories: categories,
      );
    } catch (e) {
      debugPrint('error fetch master category: $e');
    }
  }

  @override
  List<CategoryEntity> get rootCategories => _state.categories ?? [];

  @override
  Map<String, dynamic> get secondCategories => secondCategoriesTmp;
}
