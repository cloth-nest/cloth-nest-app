// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_product/attribute_entity.dart';

class AttributeModel {
  final String attributeName;
  final String value;

  AttributeModel({
    required this.attributeName,
    required this.value,
  });

  AttributeModel copyWith({
    String? attributeName,
    String? value,
  }) {
    return AttributeModel(
      attributeName: attributeName ?? this.attributeName,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'attributeName': attributeName,
      'value': value,
    };
  }

  factory AttributeModel.fromMap(Map<String, dynamic> map) {
    return AttributeModel(
      attributeName: map['attributeName'] as String,
      value: map['value'] as String,
    );
  }

  AttributeEntity toEntity() => AttributeEntity(
        attributeName: attributeName,
        value: value,
      );
}
