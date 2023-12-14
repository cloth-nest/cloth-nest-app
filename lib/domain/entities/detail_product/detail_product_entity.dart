// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_product/attribute_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/image_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/variant_entity.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/domain/entities/product_type/product_type_entity.dart';

class DetailProductEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<AttributeEntity> attributes;
  final List<ImageEntity> images;
  final ProductTypeEntity productType;
  final List<VariantEntity> variants;
  final bool? isFavorite;
  final int defaultVariantId;

  DetailProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.attributes,
    required this.images,
    required this.productType,
    required this.variants,
    this.isFavorite,
    required this.defaultVariantId,
  });

  ProductEntity toProductEntity() => ProductEntity(
        id: id,
        name: name,
        price: price,
        description: description,
        image: images.first.image,
        defaultVariantId: defaultVariantId,
      );

  DetailProductEntity copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    List<AttributeEntity>? attributes,
    List<ImageEntity>? images,
    ProductTypeEntity? productType,
    List<VariantEntity>? variants,
    bool? isFavorite,
    int? defaultVariantId,
  }) {
    return DetailProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      attributes: attributes ?? this.attributes,
      images: images ?? this.images,
      productType: productType ?? this.productType,
      variants: variants ?? this.variants,
      isFavorite: isFavorite ?? this.isFavorite,
      defaultVariantId: defaultVariantId ?? this.defaultVariantId,
    );
  }
}
