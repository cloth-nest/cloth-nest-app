import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/detail_product/fetch_detail_product.dart';
import 'package:ecommerce/domain/usecases/qr_code/delete_history_qr_code.dart';
import 'package:ecommerce/domain/usecases/qr_code/fetch_history_qr_code.dart';
import 'package:ecommerce/domain/usecases/qr_code/save_history_qr_code.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';
import 'package:ecommerce/presentation/presenters/qr_code/qr_code_state.dart';
import 'package:ecommerce/presentation/screens/qr_code/qr_code_presenter.dart';
import 'package:flutter/material.dart';

class ProviderQrCodePresenter with ChangeNotifier implements QrCodePresenter {
  QrCodeState _state;

  final FetchDetailProduct _fetchDetailProduct;
  final FetchHistoryQrCode _fetchHistoryQrCode;
  final SaveHistoryQrCode _saveHistoryQrCode;
  final DeleteHistoryQrCode _deleteHistoryQrCode;
  final SaveLocalWishlist _saveWishlist;
  final DeleteWishlist _deleteWishlist;
  final FetchWishlist _fetchWishlist;
  final SaveRemoteWishlist _saveRemoteWishlist;
  final FetchRemoteWishlist _fetchRemoteWishlist;
  final DeleteRemoteWishlist _deleteRemoteWishlist;

  ProviderQrCodePresenter({
    required QrCodeState state,
    required FetchDetailProduct fetchDetailProduct,
    required FetchHistoryQrCode fetchHistoryQrCode,
    required SaveHistoryQrCode saveHistoryQrCode,
    required DeleteHistoryQrCode deleteHistoryQrCode,
    required SaveLocalWishlist saveWishlist,
    required DeleteWishlist deleteWishlist,
    required FetchWishlist fetchWishlist,
    required SaveRemoteWishlist saveRemoteWishlist,
    required FetchRemoteWishlist fetchRemoteWishlist,
    required DeleteRemoteWishlist deleteRemoteWishlist,
  })  : _state = state,
        _fetchDetailProduct = fetchDetailProduct,
        _fetchHistoryQrCode = fetchHistoryQrCode,
        _saveHistoryQrCode = saveHistoryQrCode,
        _deleteHistoryQrCode = deleteHistoryQrCode,
        _saveWishlist = saveWishlist,
        _deleteWishlist = deleteWishlist,
        _fetchWishlist = fetchWishlist,
        _saveRemoteWishlist = saveRemoteWishlist,
        _fetchRemoteWishlist = fetchRemoteWishlist,
        _deleteRemoteWishlist = deleteRemoteWishlist;

  @override
  void initData() async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      List<ProductEntity> products = await _fetchHistoryQrCode.call();

      _state = _state.copyWith(products: [..._state.products, ...products]);

      await _updateWishList(products: _state.products);

      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    } catch (e) {
      debugPrint('##error init data qr code: $e');
    }
  }

  @override
  bool get isLoading => _state.isLoading;

  @override
  List<ProductEntity> get products => _state.products;

  @override
  void saveProduct({required int idProduct}) async {
    try {
      DetailProductEntity detailProductEntity =
          await _fetchDetailProduct.call(idProduct: idProduct);
      ProductEntity entity = ProductEntity(
        id: idProduct,
        name: detailProductEntity.name,
        price: detailProductEntity.price,
        description: detailProductEntity.description,
        image: detailProductEntity.images[0].image,
        defaultVariantId: detailProductEntity.defaultVariantId,
      );
      await _saveHistoryQrCode.call(product: entity);
      _state = _state.copyWith(products: [..._state.products, entity]);

      await _updateWishList(products: _state.products);

      notifyListeners();
    } catch (e) {
      debugPrint('###error save history qr code: $e');
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
        debugPrint('index: $index');
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

  @override
  void deleteAll() async {
    try {
      _state = _state.copyWith(
        products: [],
      );
      notifyListeners();
      await _deleteHistoryQrCode.call();
    } catch (e) {
      debugPrint('###error delete all history:$e');
    }
  }
}
