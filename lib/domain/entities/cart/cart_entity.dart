// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartEntity {
  final int variantId;
  final String name;
  final double price;
  final int productId;
  final int quantity;
  final String image;

  CartEntity({
    required this.variantId,
    required this.name,
    required this.price,
    required this.productId,
    required this.quantity,
    required this.image,
  });

  CartEntity copyWith({
    int? id,
    String? name,
    double? price,
    int? productId,
    int? quantity,
    String? image,
  }) {
    return CartEntity(
      variantId: id ?? this.variantId,
      name: name ?? this.name,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      image: image ?? this.image,
    );
  }
}
