import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';
import 'package:ecommerce/presentation/presenters/my_list/my_list_state.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';
import 'package:flutter/material.dart';

class ProviderMyListPresenter with ChangeNotifier implements MyListPresenter {
  MyListState _state;

  final FetchRemoteWishlist _fetchRemoteWishlist;
  final DeleteRemoteWishlist _deleteRemoteWishlist;
  final FetchWishlist _fetchWishlist;
  final DeleteWishlist _deleteWishlist;

  ProviderMyListPresenter({
    required MyListState state,
    required FetchRemoteWishlist fetchRemoteWishlist,
    required DeleteRemoteWishlist deleteRemoteWishlist,
    required FetchWishlist fetchWishlist,
    required DeleteWishlist deleteWishlist,
  })  : _state = state,
        _fetchRemoteWishlist = fetchRemoteWishlist,
        _deleteRemoteWishlist = deleteRemoteWishlist,
        _fetchWishlist = fetchWishlist,
        _deleteWishlist = deleteWishlist;

  @override
  bool get isLoading => _state.isLoading;

  @override
  Future getData() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      List<ProductEntity> result = [];

      final isAuthenticated = UserTokenSingleton().latestUserSession != null;

      if (isAuthenticated) {
        result = await _fetchRemoteWishlist.fetchRemote();
      } else {
        result = await _fetchWishlist.fetchLocal();
      }

      _state = _state.copyWith(
        isLoading: false,
        myListProducts: result,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      debugPrint('##error get data wishlist: $e');
    }
  }

  @override
  Future<void> refreshData() async {
    await getData();
  }

  @override
  List<ProductEntity> get myListProducts => _state.myListProducts;

  @override
  Future<void> removeFromWishlist({required ProductEntity entity}) async {
    try {
      final isAuthenticated = UserTokenSingleton().latestUserSession != null;
      _deleteProductWithoutFetch(entity);

      if (isAuthenticated) {
        await _deleteRemoteWishlist
            .deleteRemote(variantIds: [entity.defaultVariantId]);
      } else {
        await _deleteWishlist.deleteLocal(
            defautVariantId: entity.defaultVariantId);
      }
    } catch (e) {
      debugPrint('###error removeFromWishlist: $e');
    }
  }

  void _deleteProductWithoutFetch(ProductEntity product) {
    final myListProducts = [..._state.myListProducts];
    myListProducts.removeWhere((element) => element.id == product.id);
    _state = _state.copyWith(myListProducts: myListProducts);
    notifyListeners();
  }
}
