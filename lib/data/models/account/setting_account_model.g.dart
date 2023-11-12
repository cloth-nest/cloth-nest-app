// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingAccountModelAdapter extends TypeAdapter<SettingAccountModel> {
  @override
  final int typeId = 1;

  @override
  SettingAccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingAccountModel(
      isAllowSendNotification: fields[0] as bool,
      isDarkMode: fields[1] as bool,
      language: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingAccountModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isAllowSendNotification)
      ..writeByte(1)
      ..write(obj.isDarkMode)
      ..writeByte(2)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingAccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
