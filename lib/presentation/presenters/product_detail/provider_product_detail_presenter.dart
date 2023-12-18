import 'package:ecommerce/app/utils/singleton/user_token_singleton.dart';
import 'package:ecommerce/domain/entities/detail_product/attribute_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/attribute_variant_product_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/image_entity.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_add_to_cart.dart';
import 'package:ecommerce/domain/usecases/detail_product/fetch_detail_product.dart';
import 'package:ecommerce/domain/usecases/recommendation_product/fetch_recommendation_product.dart';
import 'package:ecommerce/domain/usecases/wishlist/delete_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/fetch_wishlist.dart';
import 'package:ecommerce/domain/usecases/wishlist/save_wishlist.dart';
import 'package:ecommerce/presentation/presenters/product_detail/product_detail_state.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';

class ProviderProductDetailPresenter
    with ChangeNotifier
    implements ProductDetailPresenter {
  ProductDetailState _state;

  final FetchDetailProduct _fetchDetailProduct;
  final FetchRecommendationProduct _fetchRecommendationProduct;
  final SaveLocalWishlist _saveWishlist;
  final DeleteWishlist _deleteWishlist;
  final FetchWishlist _fetchWishlist;
  final SaveRemoteWishlist _saveRemoteWishlist;
  final FetchRemoteWishlist _fetchRemoteWishlist;
  final DeleteRemoteWishlist _deleteRemoteWishlist;
  final FetchAddToCart _fetchAddToCart;

  ProviderProductDetailPresenter({
    required ProductDetailState state,
    required FetchDetailProduct fetchDetailProduct,
    required FetchRecommendationProduct fetchRecommendationProduct,
    required SaveLocalWishlist saveWishlist,
    required DeleteWishlist deleteWishlist,
    required FetchWishlist fetchWishlist,
    required SaveRemoteWishlist saveRemoteWishlist,
    required FetchRemoteWishlist fetchRemoteWishlist,
    required DeleteRemoteWishlist deleteRemoteWishlist,
    required FetchAddToCart fetchAddToCart,
  })  : _state = state,
        _fetchDetailProduct = fetchDetailProduct,
        _fetchRecommendationProduct = fetchRecommendationProduct,
        _saveWishlist = saveWishlist,
        _deleteWishlist = deleteWishlist,
        _fetchWishlist = fetchWishlist,
        _saveRemoteWishlist = saveRemoteWishlist,
        _fetchRemoteWishlist = fetchRemoteWishlist,
        _deleteRemoteWishlist = deleteRemoteWishlist,
        _fetchAddToCart = fetchAddToCart;

  @override
  int get activePage => _state.activePage;

  @override
  void setActivePage(int page) {
    _state = _state.copyWith(activePage: page);
    _state.pageController.jumpToPage(
      page,
    );
    notifyListeners();
  }

  @override
  PageController get pageController => _state.pageController;

  @override
  void setTabIndex(int newIndex) {
    if (newIndex != tabIndex) {
      _state = _state.copyWith(tabIndex: newIndex);
      notifyListeners();
    }
  }

  @override
  int get tabIndex => _state.tabIndex;

  Future<void> _updateWishList() async {
    try {
      late List<ProductEntity> wishlistProduct;

      final isAuthenticated = UserTokenSingleton().latestUserSession != null;

      if (isAuthenticated) {
        wishlistProduct = await _fetchRemoteWishlist.fetchRemote();
      } else {
        wishlistProduct = await _fetchWishlist.fetchLocal();
      }

      final index = wishlistProduct
          .indexWhere((element) => element.id == _state.entity?.id);

      DetailProductEntity? product = _state.entity;

      if (product != null && index != -1) {
        product = product.copyWith(isFavorite: true);
      } else {
        product = product?.copyWith(isFavorite: false);
      }

      _state = _state.copyWith(entity: product);
    } catch (e) {
      debugPrint('###error update wishlist in product detail: $e');
    }
  }

  @override
  void initData({required int idProduct}) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      DetailProductEntity detailProductEntity =
          await _fetchDetailProduct.call(idProduct: idProduct);

      for (var attributeVariant
          in detailProductEntity.productType.attributeVariants) {
        if (attributeVariant.name == 'Color') {
          for (var color in attributeVariant.value) {
            _state = _state.copyWith(selectedColor: color);
            break;
          }
          break;
        }
      }

      for (var attributeVariant
          in detailProductEntity.productType.attributeVariants) {
        if (attributeVariant.name == 'Size') {
          for (var size in attributeVariant.value) {
            _state = _state.copyWith(selectedSize: size);
            break;
          }
          break;
        }
      }

      // List<ProductEntity> products =
      //     await _fetchRecommendationProduct.call(idProduct: idProduct);

      _state = _state.copyWith(
        entity: detailProductEntity,
        isLoading: false,
        recommendationProducts: [],
      );
      await _updateWishList();
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  int _getVariantId() {
    for (var entity in _state.entity?.variants ?? []) {
      List<AttributeVariantProductEntity> attributes = entity.attributes;

      if (attributes[0].value == selectedSize &&
          attributes[1].value == selectedColor) {
        return entity.id;
      }
    }
    return 0;
  }

  @override
  bool get isLoading => _state.isLoading;

  @override
  List<ImageEntity> get images => _state.entity?.images ?? [];

  @override
  String get name => _state.entity?.name ?? '';

  @override
  double get price => _state.entity?.price ?? 0;

  @override
  List<AttributeEntity> get attributes => _state.entity?.attributes ?? [];

  @override
  List<ProductEntity> get recommendationProducts =>
      _state.recommendationProducts;

  @override
  List<AttributeVariantProductEntity> get colors {
    if (_state.entity == null) {
      return [];
    }

    final List<AttributeVariantProductEntity> colors = [];
    int variantId = -1;

    for (var attributeVariant in _state.entity!.productType.attributeVariants) {
      if (attributeVariant.name == 'Color') {
        variantId = attributeVariant.id;
        break;
      }
    }

    for (var attributeVariantProduct in _state.entity!.variants) {
      for (var attribute in attributeVariantProduct.attributes) {
        if (attribute.attributeId == variantId &&
            !_isExistedColor(colors, attribute.value)) {
          colors.add(attribute);
        }
      }
    }

    return colors;
  }

  bool _isExistedColor(
      List<AttributeVariantProductEntity> colors, String colorName) {
    for (var color in colors) {
      if (color.value == colorName) {
        return true;
      }
    }

    return false;
  }

  @override
  List<String> get sizes {
    if (_state.entity == null) {
      return [];
    }

    final List<String> sizes = [];

    for (var attributeVariant in _state.entity!.productType.attributeVariants) {
      if (attributeVariant.name == 'Size') {
        for (var size in attributeVariant.value) {
          sizes.add(size);
        }
        break;
      }
    }

    return sizes;
  }

  @override
  String get selectedColor => _state.selectedColor;

  @override
  String get selectedSize => _state.selectedSize;

  @override
  void setSelectedColor({required String colorName}) {
    if (colorName != _state.selectedColor) {
      _state = _state.copyWith(selectedColor: colorName);
      notifyListeners();
    }
  }

  @override
  void setSelectedSize({required String size}) {
    if (size != _state.selectedSize) {
      _state = _state.copyWith(selectedSize: size);
      notifyListeners();
    }
  }

  @override
  int getOrderImage(int id) {
    int variantImageId = -1;

    for (var attributeVariantProduct in _state.entity!.variants) {
      if (attributeVariantProduct.id == id) {
        variantImageId = attributeVariantProduct.variantImages.first;
        break;
      }
    }

    for (var image in images) {
      if (image.id == variantImageId) {
        return image.order;
      }
    }

    return 0;
  }

  @override
  bool get isFavorite => _state.entity?.isFavorite ?? false;

  void _addProductWithoutFetch() {
    _state = _state.copyWith(entity: _state.entity?.copyWith(isFavorite: true));
  }

  void _deleteProductWithoutFetch() {
    _state =
        _state.copyWith(entity: _state.entity?.copyWith(isFavorite: false));
  }

  @override
  void removeFromWishList({required ProductEntity product}) async {
    try {
      _deleteProductWithoutFetch();
      final isAuthenticated = UserTokenSingleton().latestUserSession != null;

      if (isAuthenticated) {
        await _deleteRemoteWishlist
            .deleteRemote(variantIds: [product.defaultVariantId]);
      } else {
        await _deleteWishlist.deleteLocal(
            defautVariantId: product.defaultVariantId);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('error remove from wishlist: $e');
    }
  }

  @override
  void addToWishList({required ProductEntity product}) async {
    try {
      _addProductWithoutFetch();

      final isAuthenticated = UserTokenSingleton().latestUserSession != null;

      if (isAuthenticated) {
        await _saveRemoteWishlist
            .saveRemote(variantIds: [product.defaultVariantId]);
      } else {
        await _saveWishlist.saveLocal(product: product);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('error add to wishlist: $e');
    }
  }

  @override
  DetailProductEntity? get entity => _state.entity;

  @override
  void addToCart() async {
    try {
      int variantId = _getVariantId();

      await _fetchAddToCart.call(
        variantId: variantId,
        quantity: 1,
      );

      _state = _state.copyWith(successAddToCart: true);
      notifyListeners();
    } catch (e) {
      debugPrint('###error add to cart in product detail: $e');
    }
  }

  @override
  bool? get successAddToCart => _state.successAddToCart;
}
