// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/product/product_model.dart';

class ProductEntity {
  final int id;
  final String name;
  final double price;
  final String description;
  final String image;
  final List<String>? colors;
  final bool? isFavorite;
  final int defaultVariantId;
  final int? idWishlist;
  final double? rating;
  final int? numOfReviews;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    this.colors,
    this.isFavorite = false,
    required this.defaultVariantId,
    this.idWishlist,
    this.rating,
    this.numOfReviews,
  });

  ProductModel toModel() => ProductModel(
        id: id,
        name: name,
        price: price,
        description: description,
        image: image,
        defautVariantId: defaultVariantId,
      );

  ProductEntity copyWith({
    int? id,
    String? name,
    double? price,
    String? description,
    String? image,
    List<String>? colors,
    bool? isFavorite,
    int? defaultVariantId,
    int? idWishlist,
    double? rating,
    int? numOfReviews,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      colors: colors ?? this.colors,
      isFavorite: isFavorite ?? this.isFavorite,
      defaultVariantId: defaultVariantId ?? this.defaultVariantId,
      idWishlist: idWishlist ?? this.idWishlist,
      rating: rating ?? this.rating,
      numOfReviews: numOfReviews ?? this.numOfReviews,
    );
  }
}
