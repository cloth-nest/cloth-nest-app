// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce/data/models/account/setting_account_model.dart';
import 'package:equatable/equatable.dart';

class SettingAccountEntity extends Equatable {
  final bool isAllowSendNotification;
  final bool isDarkMode;
  final String language;

  factory SettingAccountEntity.initial() {
    return const SettingAccountEntity(
      isAllowSendNotification: true,
      isDarkMode: false,
      language: 'English',
    );
  }

  const SettingAccountEntity({
    required this.isAllowSendNotification,
    required this.isDarkMode,
    required this.language,
  });

  SettingAccountModel toModel() => SettingAccountModel(
        language: language,
        isDarkMode: isDarkMode,
        isAllowSendNotification: isAllowSendNotification,
      );

  @override
  List<Object?> get props => [
        isDarkMode,
        isAllowSendNotification,
        language,
      ];

  SettingAccountEntity copyWith({
    bool? isAllowSendNotification,
    bool? isDarkMode,
    String? language,
  }) {
    return SettingAccountEntity(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      isAllowSendNotification:
          isAllowSendNotification ?? this.isAllowSendNotification,
    );
  }
}
