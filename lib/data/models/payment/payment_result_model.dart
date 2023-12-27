import 'dart:convert';

import 'package:ecommerce/domain/entities/payment/payment_result_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentResultModel {
  final String method;
  final int returnCode;
  final String returnMessage;
  final int subReturnCode;
  final String subReturnMessage;
  final String zpTransToken;
  final String orderUrl;
  final String orderToken;

  PaymentResultModel({
    required this.method,
    required this.returnCode,
    required this.returnMessage,
    required this.subReturnCode,
    required this.subReturnMessage,
    required this.zpTransToken,
    required this.orderUrl,
    required this.orderToken,
  });

  PaymentResultModel copyWith({
    String? method,
    int? returnCode,
    String? returnMessage,
    int? subReturnCode,
    String? subReturnMessage,
    String? zpTransToken,
    String? orderUrl,
    String? orderToken,
  }) {
    return PaymentResultModel(
      method: method ?? this.method,
      returnCode: returnCode ?? this.returnCode,
      returnMessage: returnMessage ?? this.returnMessage,
      subReturnCode: subReturnCode ?? this.subReturnCode,
      subReturnMessage: subReturnMessage ?? this.subReturnMessage,
      zpTransToken: zpTransToken ?? this.zpTransToken,
      orderUrl: orderUrl ?? this.orderUrl,
      orderToken: orderToken ?? this.orderToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'method': method,
      'returnCode': returnCode,
      'returnMessage': returnMessage,
      'subReturnCode': subReturnCode,
      'subReturnMessage': subReturnMessage,
      'zpTransToken': zpTransToken,
      'orderUrl': orderUrl,
      'orderToken': orderToken,
    };
  }

  factory PaymentResultModel.fromMap(Map<String, dynamic> map) {
    return PaymentResultModel(
      method: map['method'] as String,
      returnCode: map['return_code'] as int,
      returnMessage: map['return_message'] as String,
      subReturnCode: map['sub_return_code'] as int,
      subReturnMessage: map['sub_return_message'] as String,
      zpTransToken: map['zp_trans_token'] as String,
      orderUrl: map['order_url'] as String,
      orderToken: map['order_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentResultModel.fromJson(String source) =>
      PaymentResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PaymentResultEntity toEntity() => PaymentResultEntity(
        method: method,
        returnCode: returnCode,
        returnMessage: returnMessage,
        subReturnCode: subReturnCode,
        subReturnMessage: subReturnMessage,
        zpTransToken: zpTransToken,
        orderUrl: orderUrl,
        orderToken: orderToken,
      );
}
