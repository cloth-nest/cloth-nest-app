// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:ecommerce/data/models/account/setting_account_model.dart';
import 'package:equatable/equatable.dart';

class SettingAccountEntity extends Equatable {
  final bool isAllowAvailableProgram;
  final bool isAllowChasing;
  final bool isAllowContinuousPlay;
  final bool isAllowSendNotification;
  final bool isAllowAddToMyList;
  final String ageLimit;
  final String timeReceiveInformation;

  factory SettingAccountEntity.initial() {
    return SettingAccountEntity(
      isAllowAvailableProgram: false,
      isAllowChasing: true,
      isAllowContinuousPlay: true,
      isAllowSendNotification: true,
      isAllowAddToMyList: true,
      ageLimit: Platform.isIOS ? 'PG-12以上の番組を非表示' : 'R-15以上の番組を非表示',
      timeReceiveInformation: '10分',
    );
  }

  const SettingAccountEntity({
    required this.isAllowAvailableProgram,
    required this.isAllowChasing,
    required this.isAllowContinuousPlay,
    required this.isAllowSendNotification,
    required this.isAllowAddToMyList,
    required this.ageLimit,
    required this.timeReceiveInformation,
  });

  SettingAccountModel toModel() => SettingAccountModel(
        ageLimit: ageLimit,
        isAllowAddToMyList: isAllowAddToMyList,
        isAllowAvailableProgram: isAllowAvailableProgram,
        isAllowChasing: isAllowChasing,
        isAllowContinuousPlay: isAllowContinuousPlay,
        isAllowSendNotification: isAllowSendNotification,
        timeReceiveInformation: timeReceiveInformation,
      );

  @override
  List<Object?> get props => [
        isAllowAddToMyList,
        isAllowAvailableProgram,
        isAllowChasing,
        ageLimit,
        isAllowContinuousPlay,
        isAllowSendNotification,
        timeReceiveInformation,
      ];

  SettingAccountEntity copyWith({
    bool? isAllowAvailableProgram,
    bool? isAllowChasing,
    bool? isAllowContinuousPlay,
    bool? isAllowSendNotification,
    bool? isAllowAddToMyList,
    String? ageLimit,
    String? timeReceiveInformation,
    String? userId,
  }) {
    return SettingAccountEntity(
      isAllowAvailableProgram:
          isAllowAvailableProgram ?? this.isAllowAvailableProgram,
      isAllowChasing: isAllowChasing ?? this.isAllowChasing,
      isAllowContinuousPlay:
          isAllowContinuousPlay ?? this.isAllowContinuousPlay,
      isAllowSendNotification:
          isAllowSendNotification ?? this.isAllowSendNotification,
      isAllowAddToMyList: isAllowAddToMyList ?? this.isAllowAddToMyList,
      ageLimit: ageLimit ?? this.ageLimit,
      timeReceiveInformation:
          timeReceiveInformation ?? this.timeReceiveInformation,
    );
  }
}
