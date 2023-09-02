// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce/data/models/constant.dart';
import 'package:ecommerce/domain/entities/account/setting_account_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'setting_account_model.g.dart';

@HiveType(typeId: kSettingAccountModelTypeId)
class SettingAccountModel extends HiveObject {
  @HiveField(0)
  final bool isAllowAvailableProgram;

  @HiveField(1)
  final bool isAllowChasing;

  @HiveField(2)
  final bool isAllowContinuousPlay;

  @HiveField(3)
  final bool isAllowSendNotification;

  @HiveField(4)
  final bool isAllowAddToMyList;

  @HiveField(5)
  final String ageLimit;

  @HiveField(6)
  final String timeReceiveInformation;

  SettingAccountModel({
    required this.isAllowAvailableProgram,
    required this.isAllowChasing,
    required this.isAllowContinuousPlay,
    required this.isAllowSendNotification,
    required this.isAllowAddToMyList,
    required this.ageLimit,
    required this.timeReceiveInformation,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isAllowAvailableProgram': isAllowAvailableProgram,
      'isAllowChasing': isAllowChasing,
      'isAllowContinuousPlay': isAllowContinuousPlay,
      'isAllowSendNotification': isAllowSendNotification,
      'isAllowAddToMyList': isAllowAddToMyList,
      'ageLimit': ageLimit,
      'timeReceiveInformation': timeReceiveInformation,
    };
  }

  factory SettingAccountModel.fromMap(Map<String, dynamic> map) {
    return SettingAccountModel(
      isAllowAvailableProgram: map['isAllowAvailableProgram'] as bool,
      isAllowChasing: map['isAllowChasing'] as bool,
      isAllowContinuousPlay: map['isAllowContinuousPlay'] as bool,
      isAllowSendNotification: map['isAllowSendNotification'] as bool,
      isAllowAddToMyList: map['isAllowAddToMyList'] as bool,
      ageLimit: map['ageLimit'] as String,
      timeReceiveInformation: map['timeReceiveInformation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingAccountModel.fromJson(String source) =>
      SettingAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  SettingAccountEntity toEntity() {
    return SettingAccountEntity(
      isAllowAvailableProgram: isAllowAvailableProgram,
      isAllowChasing: isAllowChasing,
      isAllowContinuousPlay: isAllowContinuousPlay,
      isAllowSendNotification: isAllowSendNotification,
      isAllowAddToMyList: isAllowAddToMyList,
      ageLimit: ageLimit,
      timeReceiveInformation: timeReceiveInformation,
    );
  }
}
