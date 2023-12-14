// ignore_for_file: public_member_api_docs, sort_constructors_first
class WishlistEntity {
  final int id;
  final String name;
  final double price;
  final int productId;
  final String image;
  final int productVariantId;

  WishlistEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.productId,
    required this.image,
    required this.productVariantId,
  });
}
