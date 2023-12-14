// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/product/product_entity.dart';

class MyListState {
  final bool isLoading;
  final List<ProductEntity> myListProducts;

  MyListState({
    required this.isLoading,
    required this.myListProducts,
  });

  factory MyListState.initial() {
    return MyListState(
      isLoading: false,
      myListProducts: [],
    );
  }

  MyListState copyWith({bool? isLoading, List<ProductEntity>? myListProducts}) {
    return MyListState(
      isLoading: isLoading ?? this.isLoading,
      myListProducts: myListProducts ?? this.myListProducts,
    );
  }
}
