import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product_params.dart';
import 'package:ecommerce/presentation/presenters/detail_category/detail_category_state.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';
import 'package:flutter/material.dart';

class ProviderDetailCategoryPresenter
    with ChangeNotifier
    implements DetailCategoryPresenter {
  DetailCategoryState _state;

  final FetchProduct _fetchProduct;

  ProviderDetailCategoryPresenter({
    required DetailCategoryState state,
    required FetchProduct fetchProduct,
  })  : _state = state,
        _fetchProduct = fetchProduct;

  // data filters
  String priceTmp = '';

  @override
  void changeTab(int newIndex,
      {required int id, required int page, required int limit}) async {
    if (tabIndex != newIndex) {
      _state = _state.copyWith(
        isLoading: true,
        products: [],
        page: 1,
      );
      notifyListeners();

      await fetchProducts(id: id, page: page, limit: limit);

      _state = _state.copyWith(
        tabIndex: newIndex,
        isLoading: false,
        selectedColors: [],
        selectedPrices: [],
        selectedSizes: [],
        sort: 'Created descending',
        controller: ScrollController(),
      );
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 5));
  }

  @override
  List<String> get colors => _state.colors;

  @override
  bool get isLoading => _state.isLoading;

  @override
  List<String> get prices => _state.prices;

  @override
  List<Map<String, dynamic>> get selectedColors => _state.selectedColors;

  @override
  List<Map<String, dynamic>> get selectedPrices => _state.selectedPrices;

  @override
  List<Map<String, dynamic>> get selectedSizes => _state.selectedSizes;

  @override
  List<String> get sizes => _state.sizes;

  @override
  int get tabIndex => _state.tabIndex;

  @override
  Future pullToRefresh() async {
    _state = _state.copyWith(isLoading: true, products: [], page: 1);
    notifyListeners();

    await fetchProducts(id: _state.id, page: 1, limit: 6);

    _state = _state.copyWith(isLoading: false);
    notifyListeners();
  }

  @override
  bool get hasFilter {
    if (selectedColors.isNotEmpty ||
        selectedPrices.isNotEmpty ||
        selectedSizes.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  void setSelectedColors(List<Map<String, dynamic>> value) async {
    if (value != selectedColors) {
      bool isEmpty = true;

      for (final data in value) {
        if (data['value'] == true) {
          isEmpty = false;
          break;
        }
      }

      _state = _state.copyWith(
        isLoading: true,
        selectedColors: isEmpty ? [] : value,
      );

      notifyListeners();

      await fetchProducts(
          id: _state.id, page: _state.page, limit: _state.limit);

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  @override
  void setSelectedPrices(List<Map<String, dynamic>> value) async {
    if (value != selectedPrices) {
      bool isEmpty = true;

      for (final data in value) {
        if (data['value'] == true) {
          priceTmp = data['data'];
          isEmpty = false;
          break;
        }
      }

      _state = _state.copyWith(
        isLoading: true,
        selectedPrices: isEmpty ? [] : value,
      );

      notifyListeners();

      await fetchProducts(
          id: _state.id, page: _state.page, limit: _state.limit);

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  @override
  void setSelectedSizes(List<Map<String, dynamic>> value) async {
    if (value != selectedSizes) {
      bool isEmpty = true;

      for (final data in value) {
        if (data['value'] == true) {
          isEmpty = false;
          break;
        }
      }

      _state = _state.copyWith(
        isLoading: true,
        selectedSizes: isEmpty ? [] : value,
      );

      notifyListeners();

      await fetchProducts(
          id: _state.id, page: _state.page, limit: _state.limit);

      _state = _state.copyWith(
        isLoading: false,
      );

      notifyListeners();
    }
  }

  @override
  void setSort(String value) async {
    if (sort != value) {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();
      _state = _state.copyWith(
        sort: value,
      );

      await fetchProducts(
          id: _state.id, page: _state.page, limit: _state.limit);
      _state = _state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  @override
  String get sort => _state.sort;

  Future<List<ProductEntity>> fetchProducts({
    required int id,
    required int page,
    required int limit,
  }) async {
    try {
      List<ProductEntity> products = await _fetchProduct.call(
          params: FetchProductParams(
        page: page,
        limit: limit,
        colors: colors,
        sizes: sizes,
        idCategory: id,
        //priceRange: priceTmp,
        orderDirection: sort,
      ));
      _state = _state.copyWith(products: [..._state.products, ...products]);

      if (products.length < 6) {
        _state = _state.copyWith(canGetMore: false);
      } else {
        _state = _state.copyWith(canGetMore: true);
      }
      return products;
    } catch (e) {
      debugPrint('error fetch products: $e');
    }
    return [];
  }

  @override
  Future<void> initData({
    required int id,
    required int page,
    required int limit,
  }) async {
    try {
      _state = _state.copyWith(
        isLoading: true,
        id: id,
        page: page,
        limit: limit,
      );
      notifyListeners();

      List<ProductEntity> products =
          await fetchProducts(id: id, page: page, limit: limit);

      _state = _state.copyWith(
        tabIndex: 0,
        isLoading: false,
        selectedColors: [],
        selectedPrices: [],
        selectedSizes: [],
        sort: 'Created descending',
        products: products,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('error fetch products: $e');
    }
  }

  @override
  List<ProductEntity> get products => _state.products;

  @override
  ScrollController get controller => _state.controller;

  @override
  void scrollListener() async {
    if (isGetMore) return;
    if (controller.position.pixels > controller.position.maxScrollExtent - 30 &&
        canGetMore) {
      try {
        // Update page index
        _state = _state.copyWith(page: _state.page + 1, isGetMore: true);
        notifyListeners();
        await fetchProducts(id: _state.id, page: _state.page, limit: 6);
      } catch (e) {
        _state = _state.copyWith(canGetMore: false);
        rethrow;
      } finally {
        _state = _state.copyWith(isGetMore: false);
        notifyListeners();
      }
    }
  }

  @override
  bool get canGetMore => _state.canGetMore;

  @override
  bool get isGetMore => _state.isGetMore;
}
