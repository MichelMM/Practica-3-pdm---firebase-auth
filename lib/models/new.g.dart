// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewAdapter extends TypeAdapter<New> {
  @override
  final int typeId = 0;

  @override
  New read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return New(
      author: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      urlToImage: fields[3] as String,
      publishedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, New obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.urlToImage)
      ..writeByte(4)
      ..write(obj.publishedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
