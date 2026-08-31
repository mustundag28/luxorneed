// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 2;

  @override
  ItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModel(
      id: fields[0] as String,
      title: fields[1] as String,
      price: fields[2] as double,
      type: fields[3] as ItemType,
      status: fields[4] as ItemStatus,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
      isSynced: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt)
      ..writeByte(7)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemTypeAdapter extends TypeAdapter<ItemType> {
  @override
  final int typeId = 0;

  @override
  ItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemType.need;
      case 1:
        return ItemType.lux;
      default:
        return ItemType.need;
    }
  }

  @override
  void write(BinaryWriter writer, ItemType obj) {
    switch (obj) {
      case ItemType.need:
        writer.writeByte(0);
        break;
      case ItemType.lux:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemStatusAdapter extends TypeAdapter<ItemStatus> {
  @override
  final int typeId = 1;

  @override
  ItemStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemStatus.pending;
      case 1:
        return ItemStatus.purchased;
      case 2:
        return ItemStatus.cancelled;
      default:
        return ItemStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, ItemStatus obj) {
    switch (obj) {
      case ItemStatus.pending:
        writer.writeByte(0);
        break;
      case ItemStatus.purchased:
        writer.writeByte(1);
        break;
      case ItemStatus.cancelled:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
