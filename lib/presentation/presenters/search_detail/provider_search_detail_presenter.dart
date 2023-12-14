import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/search/fetch_search.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';
import 'package:ecommerce/presentation/presenters/search_detail/search_detail_state.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/search_detail_presenter.dart';
import 'package:flutter/material.dart';

class ProviderSearchDetailPresenter
    with ChangeNotifier
    implements SearchDetailPresenter {
  SearchDetailState _state;
  final FetchSearch _fetchSearch;
  final SaveLocalWishlist _saveWishlist;
  final DeleteWishlist _deleteWishlist;
  final FetchWishlist _fetchWishlist;
  final SaveRemoteWishlist _saveRemoteWishlist;
  final FetchRemoteWishlist _fetchRemoteWishlist;
  final DeleteRemoteWishlist _deleteRemoteWishlist;

  ProviderSearchDetailPresenter({
    required SearchDetailState state,
    required FetchSearch fetchSearch,
    required SaveLocalWishlist saveWishlist,
    required DeleteWishlist deleteWishlist,
    required FetchWishlist fetchWishlist,
    required SaveRemoteWishlist saveRemoteWishlist,
    required FetchRemoteWishlist fetchRemoteWishlist,
    required DeleteRemoteWishlist deleteRemoteWishlist,
  })  : _state = state,
        _fetchSearch = fetchSearch,
        _saveWishlist = saveWishlist,
        _deleteWishlist = deleteWishlist,
        _fetchWishlist = fetchWishlist,
        _saveRemoteWishlist = saveRemoteWishlist,
        _fetchRemoteWishlist = fetchRemoteWishlist,
        _deleteRemoteWishlist = deleteRemoteWishlist;

  @override
  Future search(String keyword) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      List<ProductEntity> products =
          await _fetchSearch.call(search: keyword, page: 1, limit: 20);

      _state = _state.copyWith(isLoading: false, searchProducts: products);

      await _updateWishList(products: _state.searchProducts);

      notifyListeners();
    } catch (e) {
      debugPrint('error search: $e');
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
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
      searchProducts: result,
      myListProducts: wishlistProduct,
    );
  }

  @override
  bool get isLoading => _state.isLoading;

  @override
  Future<void> onRefresh(String keyword) async {
    try {
      await search(keyword);
    } catch (e) {
      debugPrint('error on refresh search: $e');
    }
  }

  @override
  List<ProductEntity> get searchProducts => _state.searchProducts;

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

      final result = [..._state.searchProducts];

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
        searchProducts: result,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('error remove from wishlist: $e');
    }
  }

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
      final result = [..._state.searchProducts];

      for (int i = 0; i < result.length; i++) {
        final entity = result[i];
        final index = _state.myListProducts
            .indexWhere((element) => element.id == entity.id);
        debugPrint('index: $index');
        if (index > -1) {
          result[i] = entity.copyWith(isFavorite: true);
        } else {
          result[i] = entity.copyWith(isFavorite: false);
        }
      }
      _state = _state.copyWith(
        searchProducts: result,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('error add to wishlist: $e');
    }
  }
}
