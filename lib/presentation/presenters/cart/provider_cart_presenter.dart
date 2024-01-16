import 'package:ecommerce/domain/entities/cart/cart_entity.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_add_to_cart.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_cart.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_remove_from_cart.dart';
import 'package:ecommerce/domain/usecases/inventory/fetch_inventory.dart';
import 'package:ecommerce/presentation/presenters/cart/cart_state.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';
import 'package:flutter/material.dart';

class ProviderCartPresenter with ChangeNotifier implements CartPresenter {
  CartState _state;

  final FetchCart _fetchCart;
  final FetchAddToCart _fetchAddToCart;
  final FetchRemoveFromCart _fetchRemoveFromCart;
  final FetchInventory _fetchInventory;

  ProviderCartPresenter({
    required CartState state,
    required FetchCart fetchCart,
    required FetchAddToCart fetchAddToCart,
    required FetchRemoveFromCart fetchRemoveFromCart,
    required FetchInventory fetchInventory,
  })  : _state = state,
        _fetchCart = fetchCart,
        _fetchAddToCart = fetchAddToCart,
        _fetchRemoveFromCart = fetchRemoveFromCart,
        _fetchInventory = fetchInventory;

  @override
  bool get isLoading => _state.isLoading;

  @override
  Future<void> refreshData() async {
    await initData();
  }

  @override
  List<CartEntity> get carts => _state.carts;

  @override
  Future initData() async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      List<CartEntity> result = await _fetchCart.call();

      _state = _state.copyWith(
        carts: result,
        isLoading: false,
      );
      notifyListeners();
    } catch (e) {
      debugPrint('###error init data cart: $e');

      _state = _state.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  @override
  void addToCart({required int variantId}) async {
    try {
      _addCartWithoutFetch(variantId);
      await _fetchAddToCart.call(
        variantId: variantId,
        quantity: 1,
      );
    } catch (e) {
      debugPrint('###error add to cart: $e');
    }
  }

  @override
  void removeFromCart({required int variantId}) async {
    try {
      _deleteCartWithoutFetch(variantId);
      await _fetchRemoveFromCart.call(
        variantId: variantId,
        quantity: 1,
      );
    } catch (e) {
      debugPrint('###error remove from cart: $e');
    }
  }

  void _addCartWithoutFetch(int variantId) {
    final listCarts = [..._state.carts];

    final index =
        _state.carts.indexWhere((element) => element.variantId == variantId);

    if (index > -1) {
      int currentQuantity = listCarts[index].quantity;
      listCarts[index] = listCarts[index].copyWith(quantity: ++currentQuantity);
    }
    _state = _state.copyWith(
      carts: listCarts,
    );
    notifyListeners();
  }

  void _deleteCartWithoutFetch(int variantId) {
    final listCarts = [..._state.carts];

    final index =
        _state.carts.indexWhere((element) => element.variantId == variantId);

    if (index > -1) {
      final entity = listCarts[index];

      int currentQuantity = entity.quantity;
      if (currentQuantity == 1) {
        listCarts.removeAt(index);
      } else {
        listCarts[index] = entity.copyWith(quantity: --currentQuantity);
      }
    }

    _state = _state.copyWith(
      carts: listCarts,
    );
    notifyListeners();
  }

  @override
  void checkInventory() async {
    try {
      final bool isAvailable = await _fetchInventory.call();

      _state = _state.copyWith(isAvailable: isAvailable);
      notifyListeners();
    } catch (e) {
      debugPrint('##error check inventory: $e');
    }
  }

  @override
  bool? get isAvailable => _state.isAvailable;
}
