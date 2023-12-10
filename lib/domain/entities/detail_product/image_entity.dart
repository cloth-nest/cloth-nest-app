// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImageEntity {
  final int id;
  final String image;
  final int order;

  ImageEntity({
    required this.id,
    required this.image,
    required this.order,
  });

  ImageEntity copyWith({
    int? id,
    String? image,
    int? order,
  }) {
    return ImageEntity(
      id: id ?? this.id,
      image: image ?? this.image,
      order: order ?? this.order,
    );
  }
}
