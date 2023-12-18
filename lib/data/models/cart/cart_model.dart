// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';

class CartModel {
  final int variantId;
  final String name;
  final double price;
  final int productId;
  final int quantity;
  final String image;

  CartModel({
    required this.variantId,
    required this.name,
    required this.price,
    required this.productId,
    required this.quantity,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': variantId,
      'name': name,
      'price': price,
      'productId': productId,
      'quantity': quantity,
      'image': image,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      variantId: map['variantId'] as int,
      name: map['name'] as String,
      price: map['price'].runtimeType != double
          ? double.parse(map['price'].toString())
          : map['price'],
      productId: map['productId'] as int,
      quantity: map['quantity'] as int,
      image: map['image'] as String,
    );
  }

  CartEntity toEntity() => CartEntity(
        variantId: variantId,
        name: name,
        price: price,
        productId: productId,
        quantity: quantity,
        image: image,
      );
}
