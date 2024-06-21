// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 1;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      isDeleted: fields[2] as bool,
      type: fields[3] as CategroryType,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.isDeleted)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategroryTypeAdapter extends TypeAdapter<CategroryType> {
  @override
  final int typeId = 2;

  @override
  CategroryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CategroryType.income;
      case 1:
        return CategroryType.expanse;
      default:
        return CategroryType.income;
    }
  }

  @override
  void write(BinaryWriter writer, CategroryType obj) {
    switch (obj) {
      case CategroryType.income:
        writer.writeByte(0);
        break;
      case CategroryType.expanse:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategroryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
