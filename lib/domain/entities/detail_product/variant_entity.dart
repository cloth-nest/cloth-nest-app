// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/detail_product/attribute_variant_product_entity.dart';
import 'package:ecommerce/domain/entities/detail_product/warehouse_stock_entity.dart';

class VariantEntity {
  final int id;
  final String sku;
  final String name;
  final int order;
  final double price;
  final List<int> variantImages;
  final List<WarehouseStockEntity> warehouseStocks;
  final List<AttributeVariantProductEntity> attributes;

  VariantEntity({
    required this.id,
    required this.sku,
    required this.name,
    required this.order,
    required this.price,
    required this.variantImages,
    required this.warehouseStocks,
    required this.attributes,
  });

  factory VariantEntity.initial() {
    return VariantEntity(
      id: 0,
      sku: '',
      name: '',
      order: 0,
      price: 0,
      variantImages: [],
      warehouseStocks: [],
      attributes: [],
    );
  }
}
