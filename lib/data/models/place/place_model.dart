import 'package:ecommerce/domain/entities/place/place_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceModel {
  final String name;
  final int code;

  PlaceModel({
    required this.name,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      name: map['name'],
      code: map['code'],
    );
  }

  PlaceEntity toEntity() => PlaceEntity(
        code: code,
        name: name,
      );
}
