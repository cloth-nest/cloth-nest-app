// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/entities/wishlist/wishlist_entity.dart';

class WishlistModel {
  final int id;
  final String name;
  final double price;
  final int productId;
  final String image;
  final int productVariantId;

  WishlistModel({
    required this.id,
    required this.name,
    required this.price,
    required this.productId,
    required this.image,
    required this.productVariantId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'productId': productId,
      'image': image,
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'].runtimeType != double
          ? double.parse(map['price'].toString())
          : map['price'],
      productId: map['productId'] as int,
      image: map['image'] as String,
      productVariantId: map['productVariantId'],
    );
  }

  WishlistEntity toEntity() => WishlistEntity(
        id: id,
        name: name,
        price: price,
        productId: productId,
        image: image,
        productVariantId: productVariantId,
      );

  ProductEntity toProductEntity() => ProductEntity(
        idWishlist: id,
        id: productId,
        name: name,
        price: price,
        description: '',
        image: image,
        defaultVariantId: productVariantId,
      );
}
