import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product_params.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';
import 'package:ecommerce/presentation/presenters/detail_category/detail_category_state.dart';
import 'package:ecommerce/presentation/screens/detail_category/detail_category_presenter.dart';
import 'package:flutter/material.dart';

class ProviderDetailCategoryPresenter
    with ChangeNotifier
    implements DetailCategoryPresenter {
  DetailCategoryState _state;

  final FetchProduct _fetchProduct;
  final SaveLocalWishlist _saveWishlist;
  final DeleteWishlist _deleteWishlist;
  final FetchWishlist _fetchWishlist;
  final SaveRemoteWishlist _saveRemoteWishlist;
  final FetchRemoteWishlist _fetchRemoteWishlist;
  final DeleteRemoteWishlist _deleteRemoteWishlist;

  ProviderDetailCategoryPresenter({
    required DetailCategoryState state,
    required FetchProduct fetchProduct,
    required SaveLocalWishlist saveWishlist,
    required DeleteWishlist deleteWishlist,
    required FetchWishlist fetchWishlist,
    required SaveRemoteWishlist saveRemoteWishlist,
    required FetchRemoteWishlist fetchRemoteWishlist,
    required DeleteRemoteWishlist deleteRemoteWishlist,
  })  : _state = state,
        _fetchProduct = fetchProduct,
        _saveWishlist = saveWishlist,
        _deleteWishlist = deleteWishlist,
        _fetchWishlist = fetchWishlist,
        _saveRemoteWishlist = saveRemoteWishlist,
        _fetchRemoteWishlist = fetchRemoteWishlist,
        _deleteRemoteWishlist = deleteRemoteWishlist;

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
        id: id,
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

      if (isEmpty) {
        priceTmp = '';
      }

      _state = _state.copyWith(
        isLoading: true,
        selectedPrices: isEmpty ? [] : value,
      );

      notifyListeners();

      List<ProductEntity> products = await _fetchProduct.call(
          params: FetchProductParams(
        page: _state.page,
        limit: _state.limit,
        colors: colors,
        sizes: sizes,
        idCategory: _state.id,
        priceRange: priceTmp,
        orderDirection: sort,
      ));

      _state = _state.copyWith(products: [...products]);

      await _updateWishList(products: _state.products);

      if (products.length < 6) {
        _state = _state.copyWith(canGetMore: false);
      } else {
        _state = _state.copyWith(canGetMore: true);
      }

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

      List<ProductEntity> products = await _fetchProduct.call(
          params: FetchProductParams(
        page: _state.page,
        limit: _state.limit,
        colors: colors,
        sizes: sizes,
        idCategory: _state.id,
        priceRange: priceTmp,
        orderDirection: sort,
      ));

      _state = _state.copyWith(products: [...products]);

      await _updateWishList(products: _state.products);

      if (products.length < 6) {
        _state = _state.copyWith(canGetMore: false);
      } else {
        _state = _state.copyWith(canGetMore: true);
      }

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

      List<ProductEntity> products = await _fetchProduct.call(
          params: FetchProductParams(
        page: _state.page,
        limit: _state.limit,
        colors: colors,
        sizes: sizes,
        idCategory: _state.id,
        priceRange: priceTmp,
        orderDirection: sort,
      ));

      _state = _state.copyWith(products: [...products]);

      await _updateWishList(products: _state.products);

      if (products.length < 6) {
        _state = _state.copyWith(canGetMore: false);
      } else {
        _state = _state.copyWith(canGetMore: true);
      }

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
        priceRange: priceTmp,
        orderDirection: sort,
      ));

      _state = _state.copyWith(products: [..._state.products, ...products]);

      await _updateWishList(products: _state.products);

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

      await fetchProducts(id: id, page: page, limit: limit);

      _state = _state.copyWith(
        tabIndex: 0,
        isLoading: false,
        selectedColors: [],
        selectedPrices: [],
        selectedSizes: [],
        sort: 'Created descending',
      );
      notifyListeners();
    } catch (e) {
      debugPrint('error fetch products: $e');
    }
  }

  Future<void> _updateWishList({required List<ProductEntity> products}) async {
    late List<ProductEntity> wishlistProduct;

    final isAuthenticated = UserTokenSingleton().latestUserSession != null;

    if (isAuthenticated) {
      wishlistProduct = await _fetchRemoteWishlist.fetchRemote();
    } else {
      wishlistProduct = await _fetchWishlist.fetchLocal();
    }

    final result = [...products];

    for (int i = 0; i < result.length; i++) {
      final entity = result[i];
      final index =
          wishlistProduct.indexWhere((element) => element.id == entity.id);

      if (index > -1) {
        result[i] = entity.copyWith(isFavorite: true);
      } else {
        result[i] = entity.copyWith(isFavorite: false);
      }
    }

    _state = _state.copyWith(
      products: result,
      myListProducts: wishlistProduct,
    );
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

  @override
  void addToWishList({required ProductEntity product}) async {
    try {
      _addProductWithoutFetch(product);

      final isAuthenticated = UserTokenSingleton().latestUserSession != null;

      if (isAuthenticated) {
        await _saveRemoteWishlist
            .saveRemote(variantIds: [product.defaultVariantId]);
      } else {
        await _saveWishlist.saveLocal(product: product);
      }
      final result = [..._state.products];

      for (int i = 0; i < result.length; i++) {
        final entity = result[i];
        final index = _state.myListProducts
            .indexWhere((element) => element.id == entity.id);
        if (index > -1) {
          result[i] = entity.copyWith(isFavorite: true);
        } else {
          result[i] = entity.copyWith(isFavorite: false);
        }
      }
      _state = _state.copyWith(
        products: result,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('error add to wishlist: $e');
    }
  }

  void _addProductWithoutFetch(ProductEntity product) {
    final myListProducts = _state.myListProducts;
    myListProducts.add(product);
    _state = _state.copyWith(myListProducts: myListProducts);
  }

  void _deleteProductWithoutFetch(ProductEntity product) {
    final myListProducts = [..._state.myListProducts];
    myListProducts.removeWhere((element) => element.id == product.id);
    _state = _state.copyWith(myListProducts: myListProducts);
  }

  @override
  void removeFromWishList({required ProductEntity product}) async {
    try {
      _deleteProductWithoutFetch(product);
      final isAuthenticated = UserTokenSingleton().latestUserSession != null;

      if (isAuthenticated) {
        await _deleteRemoteWishlist
            .deleteRemote(variantIds: [product.defaultVariantId]);
      } else {
        await _deleteWishlist.deleteLocal(
            defautVariantId: product.defaultVariantId);
      }

      final result = [..._state.products];

      for (int i = 0; i < result.length; i++) {
        final entity = result[i];
        final index = _state.myListProducts
            .indexWhere((element) => element.id == entity.id);
        if (index > -1) {
          result[i] = entity.copyWith(isFavorite: true);
        } else {
          result[i] = entity.copyWith(isFavorite: false);
        }
      }
      _state = _state.copyWith(
        products: result,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('error remove from wishlist: $e');
    }
  }
}
