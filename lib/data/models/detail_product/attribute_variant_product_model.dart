// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce/domain/entities/detail_product/attribute_variant_product_entity.dart';

class AttributeVariantProductModel {
  final int id;
  final String value;
  final int attributeId;
  final int order;
  final int variantId;

  AttributeVariantProductModel({
    required this.id,
    required this.value,
    required this.attributeId,
    required this.order,
    required this.variantId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'attributeId': attributeId,
      'order': order,
      'variantId': variantId,
    };
  }

  factory AttributeVariantProductModel.fromMap(Map<String, dynamic> map) {
    return AttributeVariantProductModel(
      id: map['id'] as int,
      value: map['value'] as String,
      attributeId: map['attributeId'] as int,
      order: map['order'] as int,
      variantId: map['variantId'] as int,
    );
  }

  AttributeVariantProductEntity toEntity() => AttributeVariantProductEntity(
        id: id,
        value: value,
        attributeId: attributeId,
        order: order,
        variantId: variantId,
      );
}
