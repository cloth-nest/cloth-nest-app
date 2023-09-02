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
      isAllowAvailableProgram: fields[0] as bool,
      isAllowChasing: fields[1] as bool,
      isAllowContinuousPlay: fields[2] as bool,
      isAllowSendNotification: fields[3] as bool,
      isAllowAddToMyList: fields[4] as bool,
      ageLimit: fields[5] as String,
      timeReceiveInformation: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingAccountModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.isAllowAvailableProgram)
      ..writeByte(1)
      ..write(obj.isAllowChasing)
      ..writeByte(2)
      ..write(obj.isAllowContinuousPlay)
      ..writeByte(3)
      ..write(obj.isAllowSendNotification)
      ..writeByte(4)
      ..write(obj.isAllowAddToMyList)
      ..writeByte(5)
      ..write(obj.ageLimit)
      ..writeByte(6)
      ..write(obj.timeReceiveInformation);
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
