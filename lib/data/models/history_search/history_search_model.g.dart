// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistorySearchModelAdapter extends TypeAdapter<HistorySearchModel> {
  @override
  final int typeId = 4;

  @override
  HistorySearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistorySearchModel(
      keywords: (fields[0] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HistorySearchModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.keywords);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistorySearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
