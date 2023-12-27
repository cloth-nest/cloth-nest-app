// ignore_for_file: public_member_api_docs, sort_constructors_first
class OrderDetailEntity {
  final int id;
  final int quantity;
  final double price;
  final String image;
  final String name;

  OrderDetailEntity({
    required this.id,
    required this.quantity,
    required this.price,
    required this.image,
    required this.name,
  });
}
