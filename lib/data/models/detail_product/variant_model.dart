// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/detail_product/attribute_variant_product_model.dart';
import 'package:ecommerce/data/models/detail_product/warehouse_stock_model.dart';
import 'package:ecommerce/domain/entities/detail_product/variant_entity.dart';

class VariantModel {
  final int id;
  final String sku;
  final String name;
  final int order;
  final double price;
  final List<int> variantImages;
  final List<WarehouseStockModel> warehouseStocks;
  final List<AttributeVariantProductModel> attributes;

  VariantModel({
    required this.id,
    required this.sku,
    required this.name,
    required this.order,
    required this.price,
    required this.variantImages,
    required this.warehouseStocks,
    required this.attributes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sku': sku,
      'name': name,
      'order': order,
      'price': price,
      'variantImages': variantImages,
      'warehouseStocks': warehouseStocks.map((x) => x.toMap()).toList(),
      'attributes': attributes.map((x) => x.toMap()).toList(),
    };
  }

  factory VariantModel.fromMap(Map<String, dynamic> map) {
    return VariantModel(
      id: map['id'] as int,
      sku: map['sku'] as String,
      name: map['name'] as String,
      order: map['order'] as int,
      price: map['price'].runtimeType != double
          ? double.parse(map['price'].toString())
          : map['price'],
      variantImages: List<int>.from(
        (map['variantImages']),
      ),
      warehouseStocks: List<WarehouseStockModel>.from(
        (map['warehouseStocks']).map<WarehouseStockModel>(
          (x) => WarehouseStockModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      attributes: List<AttributeVariantProductModel>.from(
        (map['attributes']).map<AttributeVariantProductModel>(
          (x) =>
              AttributeVariantProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  VariantEntity toEntity() => VariantEntity(
        id: id,
        sku: sku,
        name: name,
        order: order,
        price: price,
        variantImages: variantImages,
        warehouseStocks: warehouseStocks.map((e) => e.toEntity()).toList(),
        attributes: attributes.map((e) => e.toEntity()).toList(),
      );
}
