// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/detail_product/attribute_model.dart';
import 'package:ecommerce/data/models/detail_product/image_model.dart';
import 'package:ecommerce/data/models/detail_product/variant_model.dart';
import 'package:ecommerce/data/models/product_type/product_type_model.dart';
import 'package:ecommerce/domain/entities/detail_product/detail_product_entity.dart';

class DetailProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<AttributeModel> attributes;
  final List<ImageModel> images;
  final ProductTypeModel productType;
  final List<VariantModel> variants;

  DetailProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.attributes,
    required this.images,
    required this.productType,
    required this.variants,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'attributes': attributes.map((x) => x.toMap()).toList(),
      'images': images.map((x) => x.toMap()).toList(),
      'productType': productType.toMap(),
      'variants': variants.map((x) => x.toMap()).toList(),
    };
  }

  factory DetailProductModel.fromMap(Map<String, dynamic> map) {
    return DetailProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'].runtimeType != double
          ? double.parse(map['price'].toString())
          : map['price'],
      attributes: List<AttributeModel>.from(
        (map['attributes']).map<AttributeModel>(
          (x) => AttributeModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      images: List<ImageModel>.from(
        (map['images']).map<ImageModel>(
          (x) => ImageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      productType:
          ProductTypeModel.fromMap(map['productType'] as Map<String, dynamic>),
      variants: List<VariantModel>.from(
        (map['variants']).map<VariantModel>(
          (x) => VariantModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  DetailProductEntity toEntity() => DetailProductEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        attributes: attributes.map((e) => e.toEntity()).toList(),
        images: images.map((e) => e.toEntity()).toList(),
        productType: productType.toEntity(),
        variants: variants.map((e) => e.toEntity()).toList(),
      );
}
