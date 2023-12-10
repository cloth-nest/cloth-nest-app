import 'package:ecommerce/domain/entities/detail_product/attribute_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/image_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/variant_entity.dart';
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

  DetailProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.attributes,
    required this.images,
    required this.productType,
    required this.variants,
  });
}
