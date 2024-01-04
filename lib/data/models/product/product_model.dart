// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/constant.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';

@HiveType(typeId: kProductTypeId)
class ProductModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String image;

  @HiveField(5)
  final List<String>? colors;

  @HiveField(6)
  final int defautVariantId;

  @HiveField(7)
  final double? rating;

  @HiveField(7)
  final int? numOfReviews;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    this.colors,
    required this.defautVariantId,
    this.rating,
    this.numOfReviews,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'colors': colors,
      'defautVariantId': defautVariantId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: map['price'].runtimeType != double
          ? double.parse(map['price'].toString())
          : map['price'],
      description: map['description'] as String,
      image: map['image'] as String,
      colors: map['colors'] != null ? List<String>.from((map['colors'])) : null,
      defautVariantId: map['defautVariantId'] ??
          map['defaultVariant'] ??
          map['defaultVariantId'],
      rating: map['rating'] != null ? map['rating'] * 1.0 : null,
      numOfReviews: map['numOfReviews'],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      price: price,
      description: description,
      image: image,
      colors: colors,
      defaultVariantId: defautVariantId,
      rating: rating,
      numOfReviews: numOfReviews,
    );
  }
}
