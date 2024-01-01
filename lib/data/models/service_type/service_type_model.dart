import 'dart:convert';

import 'package:ecommerce/domain/entities/service_type/service_type_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServiceTypeModel {
  final int serviceId;
  final int serviceTypeId;
  final String shortName;

  ServiceTypeModel({
    required this.serviceId,
    required this.serviceTypeId,
    required this.shortName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'serviceTypeId': serviceTypeId,
      'shortName': shortName,
    };
  }

  factory ServiceTypeModel.fromMap(Map<String, dynamic> map) {
    return ServiceTypeModel(
      serviceId: map['service_id'] as int,
      serviceTypeId: map['service_type_id'] as int,
      shortName: map['short_name'] as String,
    );
  }

  ServiceTypeEntity toEntity() {
    return ServiceTypeEntity(
      serviceId: serviceId,
      serviceTypeId: serviceTypeId,
      shortName: shortName == 'Chuyển phát thương mại điện tử'
          ? 'Normal Delivery'
          : 'Fast Delivery',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceTypeModel.fromJson(String source) =>
      ServiceTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
