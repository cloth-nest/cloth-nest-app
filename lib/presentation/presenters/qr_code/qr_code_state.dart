// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/product/product_entity.dart';

class QrCodeState {
  final bool isLoading;
  final List<ProductEntity> products;
  final List<ProductEntity> myListProducts;

  QrCodeState({
    required this.isLoading,
    required this.products,
    required this.myListProducts,
  });

  factory QrCodeState.initial() => QrCodeState(
        isLoading: false,
        products: [],
        myListProducts: [],
      );

  QrCodeState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    List<ProductEntity>? myListProducts,
  }) {
    return QrCodeState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      myListProducts: myListProducts ?? this.myListProducts,
    );
  }
}
