// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_product/attribute_variant_entity.dart';

class ProductTypeEntity {
  final String name;
  final int id;
  final String sizeChartImage;
  final List<AttributeVariantEntity> attributeVariants;

  ProductTypeEntity({
    required this.name,
    required this.id,
    required this.sizeChartImage,
    required this.attributeVariants,
  });

  ProductTypeEntity copyWith({
    String? name,
    int? id,
    String? sizeChartImage,
    List<AttributeVariantEntity>? attributeVariants,
  }) {
    return ProductTypeEntity(
      name: name ?? this.name,
      id: id ?? this.id,
      sizeChartImage: sizeChartImage ?? this.sizeChartImage,
      attributeVariants: attributeVariants ?? this.attributeVariants,
    );
  }
}
