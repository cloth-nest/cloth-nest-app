import 'package:ecommerce/domain/entities/detail_product/attribute_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/attribute_variant_product_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/image_entity.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/usecases/detail_product/fetch_detail_product.dart';
import 'package:ecommerce/domain/usecases/recommendation_product/fetch_recommendation_product.dart';
import 'package:ecommerce/presentation/presenters/product_detail/product_detail_state.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';

class ProviderProductDetailPresenter
    with ChangeNotifier
    implements ProductDetailPresenter {
  ProductDetailState _state;

  final FetchDetailProduct _fetchDetailProduct;
  final FetchRecommendationProduct _fetchRecommendationProduct;

  ProviderProductDetailPresenter({
    required ProductDetailState state,
    required FetchDetailProduct fetchDetailProduct,
    required FetchRecommendationProduct fetchRecommendationProduct,
  })  : _state = state,
        _fetchDetailProduct = fetchDetailProduct,
        _fetchRecommendationProduct = fetchRecommendationProduct;

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

      List<ProductEntity> products =
          await _fetchRecommendationProduct.call(idProduct: idProduct);

      _state = _state.copyWith(
        entity: detailProductEntity,
        isLoading: false,
        recommendationProducts: products,
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
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
}
