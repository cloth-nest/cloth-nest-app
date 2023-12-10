// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductEntity {
  final int id;
  final String name;
  final double price;
  final String description;
  final String image;
  final List<String>? colors;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    this.colors,
  });
}
