// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_order/order_detail_entity.dart';

class OrderEntity {
  final int id;
  final String status;
  final double total;
  final String createdAt;
  final String detail;
  final List<OrderDetailEntity> orderDetails;
  final String provinceName;
  final String districtName;
  final String wardName;
  final String phone;
  final String firstName;
  final String lastName;
  final double shippingFee;
  final double vatFee;
  final double subTotal;

  OrderEntity({
    required this.id,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.detail,
    required this.orderDetails,
    required this.provinceName,
    required this.districtName,
    required this.wardName,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.shippingFee,
    required this.vatFee,
    required this.subTotal,
  });
}
