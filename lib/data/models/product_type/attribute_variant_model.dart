// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_product/attribute_variant_entity.dart';

class AttributeVariantModel {
  final int id;
  final int order;
  final String name;
  final List<String> value;
  AttributeVariantModel({
    required this.id,
    required this.order,
    required this.name,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order': order,
      'name': name,
      'value': value,
    };
  }

  factory AttributeVariantModel.fromMap(Map<String, dynamic> map) {
    return AttributeVariantModel(
      id: map['id'] as int,
      order: map['order'] as int,
      name: map['name'] as String,
      value: List<String>.from(map['value']),
    );
  }

  AttributeVariantEntity toEntity() =>
      AttributeVariantEntity(id: id, order: order, name: name, value: value);
}
