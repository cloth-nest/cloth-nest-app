import 'package:ecommerce/domain/entities/detail_product/warehouse_stock_entity.dart';

class WarehouseStockModel {
  final int quantity;
  final String warehouse;
  WarehouseStockModel({
    required this.quantity,
    required this.warehouse,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'warehouse': warehouse,
    };
  }

  factory WarehouseStockModel.fromMap(Map<String, dynamic> map) {
    return WarehouseStockModel(
      quantity: map['quantity'] as int,
      warehouse: map['warehouse'] as String,
    );
  }

  WarehouseStockEntity toEntity() => WarehouseStockEntity(
        quantity: quantity,
        warehouse: warehouse,
      );
}
