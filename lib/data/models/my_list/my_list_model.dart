import 'package:ecommerce/domain/entities/my_list/my_list_entity.dart';
import 'package:hive/hive.dart';

import 'package:ecommerce/data/models/constant.dart';

part 'my_list_model.g.dart';

@HiveType(typeId: kMyListModelTypeId)
class MyListModel extends HiveObject {
  @HiveField(0)
  final String thumbnail;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String color;

  @HiveField(4)
  final String size;

  @HiveField(5)
  final String price;

  MyListModel({
    required this.thumbnail,
    required this.name,
    required this.id,
    required this.color,
    required this.size,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'thumbnail': thumbnail,
      'name': name,
      'id': id,
      'color': color,
      'size': size,
      'price': price,
    };
  }

  factory MyListModel.fromMap(Map<String, dynamic> map) {
    return MyListModel(
      thumbnail: map['thumbnail'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
      color: map['color'] as String,
      size: map['size'] as String,
      price: map['price'] as String,
    );
  }

  MyListEntity toEntity() => MyListEntity(
        thumbnail: thumbnail,
        name: name,
        id: id,
        color: color,
        size: size,
        price: price,
      );
}
