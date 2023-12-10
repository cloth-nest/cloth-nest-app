// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_product/image_entity.dart';

class ImageModel {
  final int id;
  final String image;
  final int order;

  ImageModel({
    required this.id,
    required this.image,
    required this.order,
  });

  ImageModel copyWith({
    int? id,
    String? image,
    int? order,
  }) {
    return ImageModel(
      id: id ?? this.id,
      image: image ?? this.image,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'order': order,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as int,
      image: map['image'] as String,
      order: map['order'] as int,
    );
  }

  ImageEntity toEntity() => ImageEntity(id: id, image: image, order: order);
}
