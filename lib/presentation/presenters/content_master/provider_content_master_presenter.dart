import 'package:ecommerce/domain/entities/category/category_entity.dart';
import 'package:ecommerce/domain/usecases/category/fetch_master_category.dart';
import 'package:ecommerce/presentation/presenters/content_master/content_master_state.dart';
import 'package:ecommerce/presentation/screens/content_master/content_master_presenter.dart';
import 'package:flutter/widgets.dart';

class ProviderContentMasterPresenter
    with ChangeNotifier
    implements ContentMasterPresenter {
  final FetchMasterCategory _fetchMasterCategory;

  ContentMasterState _state = ContentMasterState.initial();

  ProviderContentMasterPresenter({
    required FetchMasterCategory fetchMasterCategory,
  }) : _fetchMasterCategory = fetchMasterCategory;

  @override
  Future<void> fetchMasterCategory() async {
    try {
      final masterCategoryEntity = await _fetchMasterCategory.call();
      _state = _state.copyWith(masterCategoryEntity: masterCategoryEntity);
    } catch (e) {
      debugPrint('error fetch master category: $e');
    }
  }

  @override
  List<CategoryEntity> get searchCategories =>
      _state.masterCategoryEntity!.search;

  @override
  List<CategoryEntity> get topCategories => _state.masterCategoryEntity!.top;
}
