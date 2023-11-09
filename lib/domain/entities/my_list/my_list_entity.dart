import 'package:ecommerce/data/models/my_list/my_list_model.dart';

class MyListEntity {
  final String thumbnail;
  final String name;
  final String id;
  final String color;
  final String size;
  final String price;

  MyListEntity({
    required this.thumbnail,
    required this.name,
    required this.id,
    required this.color,
    required this.size,
    required this.price,
  });

  MyListModel toModel() => MyListModel(
        thumbnail: thumbnail,
        name: name,
        id: id,
        color: color,
        size: size,
        price: price,
      );
}
