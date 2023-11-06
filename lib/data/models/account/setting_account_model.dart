// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce/data/models/constant.dart';
import 'package:ecommerce/domain/entities/account/setting_account_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'setting_account_model.g.dart';

@HiveType(typeId: kSettingAccountModelTypeId)
class SettingAccountModel extends HiveObject {
  @HiveField(0)
  final bool isAllowSendNotification;

  @HiveField(1)
  final bool isDarkMode;

  @HiveField(2)
  final String language;

  SettingAccountModel({
    required this.isAllowSendNotification,
    required this.isDarkMode,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'isDarkMode': isDarkMode,
      'isAllowSendNotification': isAllowSendNotification,
    };
  }

  factory SettingAccountModel.fromMap(Map<String, dynamic> map) {
    return SettingAccountModel(
      isAllowSendNotification: map['isAllowSendNotification'] as bool,
      isDarkMode: map['isDarkMode'] as bool,
      language: map['language'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingAccountModel.fromJson(String source) =>
      SettingAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  SettingAccountEntity toEntity() {
    return SettingAccountEntity(
      language: language,
      isDarkMode: isDarkMode,
      isAllowSendNotification: isAllowSendNotification,
    );
  }
}
