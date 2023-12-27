// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_order/order_detail_entity.dart';

class OrderDetailModel {
  final int id;
  final int quantity;
  final double price;
  final String image;
  final String name;

  OrderDetailModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.image,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'price': price,
      'image': image,
    };
  }

  factory OrderDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderDetailModel(
      id: map['id'] as int,
      quantity: map['quantity'] as int,
      price: map['price'] * 1.0,
      image:
          map['productVariant'] != null ? map['productVariant']['image'] : '',
      name: map['productVariant'] != null ? map['productVariant']['name'] : '',
    );
  }

  OrderDetailEntity toEntity() => OrderDetailEntity(
        id: id,
        quantity: quantity,
        price: price,
        image: image,
        name: name,
      );
}
