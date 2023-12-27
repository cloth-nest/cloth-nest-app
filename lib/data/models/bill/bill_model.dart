import 'package:ecommerce/domain/entities/bill/bill_entity.dart';

class BillModel {
  final double total;
  final double shippingFee;
  final double totalBeforeVAT;
  final double totalAfterVAT;
  final double vatFee;

  BillModel({
    required this.total,
    required this.shippingFee,
    required this.totalBeforeVAT,
    required this.totalAfterVAT,
    required this.vatFee,
  });

  BillModel copyWith({
    double? total,
    double? shippingFee,
    double? totalBeforeVAT,
    double? totalAfterVAT,
    double? vatFee,
  }) {
    return BillModel(
      total: total ?? this.total,
      shippingFee: shippingFee ?? this.shippingFee,
      totalBeforeVAT: totalBeforeVAT ?? this.totalBeforeVAT,
      totalAfterVAT: totalAfterVAT ?? this.totalAfterVAT,
      vatFee: vatFee ?? this.vatFee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'shippingFee': shippingFee,
      'totalBeforeVAT': totalBeforeVAT,
      'totalAfterVAT': totalAfterVAT,
      'vatFee': vatFee,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      total: map['total'] * 1.0,
      shippingFee: map['shippingFee'] * 1.0,
      totalBeforeVAT: map['totalBeforeVAT'] * 1.0,
      totalAfterVAT: map['totalAfterVAT'] * 1.0,
      vatFee: map['vatFee'] * 1.0,
    );
  }

  BillEntity toEntity() => BillEntity(
        total: total,
        shippingFee: shippingFee,
        totalBeforeVAT: totalBeforeVAT,
        totalAfterVAT: totalAfterVAT,
        vatFee: vatFee,
      );
}
