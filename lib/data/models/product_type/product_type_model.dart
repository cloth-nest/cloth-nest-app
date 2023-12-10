// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce/data/models/product_type/attribute_variant_model.dart';
import 'package:ecommerce/domain/entities/product_type/product_type_entity.dart';

class ProductTypeModel {
  final String name;
  final int id;
  final String sizeChartImage;
  final List<AttributeVariantModel> attributeVariants;

  ProductTypeModel({
    required this.name,
    required this.id,
    required this.sizeChartImage,
    required this.attributeVariants,
  });

  ProductTypeModel copyWith({
    String? name,
    int? id,
    String? sizeChartImage,
    List<AttributeVariantModel>? attributeVariants,
  }) {
    return ProductTypeModel(
      name: name ?? this.name,
      id: id ?? this.id,
      sizeChartImage: sizeChartImage ?? this.sizeChartImage,
      attributeVariants: attributeVariants ?? this.attributeVariants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'sizeChartImage': sizeChartImage,
      'attributeVariants': attributeVariants.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductTypeModel.fromMap(Map<String, dynamic> map) {
    return ProductTypeModel(
      name: map['name'] as String,
      id: map['id'] as int,
      sizeChartImage: map['sizeChartImage'] as String,
      attributeVariants: List<AttributeVariantModel>.from(
        (map['attributeVariants']).map<AttributeVariantModel>(
          (x) => AttributeVariantModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  ProductTypeEntity toEntity() => ProductTypeEntity(
        name: name,
        id: id,
        sizeChartImage: sizeChartImage,
        attributeVariants: attributeVariants.map((e) => e.toEntity()).toList(),
      );
}
