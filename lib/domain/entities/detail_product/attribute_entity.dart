// ignore_for_file: public_member_api_docs, sort_constructors_first
class AttributeEntity {
  final String attributeName;
  final String value;

  AttributeEntity({
    required this.attributeName,
    required this.value,
  });

  AttributeEntity copyWith({
    String? attributeName,
    String? value,
  }) {
    return AttributeEntity(
      attributeName: attributeName ?? this.attributeName,
      value: value ?? this.value,
    );
  }
}
