// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyListModelAdapter extends TypeAdapter<MyListModel> {
  @override
  final int typeId = 5;

  @override
  MyListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyListModel(
      thumbnail: fields[0] as String,
      name: fields[1] as String,
      id: fields[2] as String,
      color: fields[3] as String,
      size: fields[4] as String,
      price: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyListModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.thumbnail)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
