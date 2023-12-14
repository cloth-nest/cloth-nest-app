import 'package:ecommerce/domain/entities/product/product_entity.dart';

class SearchDetailState {
  final bool isLoading;
  final List<ProductEntity> searchProducts;
  final List<ProductEntity> myListProducts;

  SearchDetailState({
    required this.isLoading,
    required this.searchProducts,
    required this.myListProducts,
  });

  factory SearchDetailState.initial() {
    return SearchDetailState(
      isLoading: false,
      searchProducts: [],
      myListProducts: [],
    );
  }

  SearchDetailState copyWith({
    bool? isLoading,
    List<ProductEntity>? searchProducts,
    List<ProductEntity>? myListProducts,
  }) {
    return SearchDetailState(
      isLoading: isLoading ?? this.isLoading,
      searchProducts: searchProducts ?? this.searchProducts,
      myListProducts: myListProducts ?? this.myListProducts,
    );
  }
}
