// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoModelAdapter extends TypeAdapter<TodoModel> {
  @override
  final int typeId = 0;

  @override
  TodoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoModel(
      title: fields[1] as String,
      description: fields[2] as String,
      color: fields[3] as TodoColor,
    );
  }

  @override
  void write(BinaryWriter writer, TodoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TodoColorAdapter extends TypeAdapter<TodoColor> {
  @override
  final int typeId = 1;

  @override
  TodoColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TodoColor.green;
      case 1:
        return TodoColor.red;
      case 2:
        return TodoColor.blue;
      case 3:
        return TodoColor.black;
      default:
        return TodoColor.green;
    }
  }

  @override
  void write(BinaryWriter writer, TodoColor obj) {
    switch (obj) {
      case TodoColor.green:
        writer.writeByte(0);
        break;
      case TodoColor.red:
        writer.writeByte(1);
        break;
      case TodoColor.blue:
        writer.writeByte(2);
        break;
      case TodoColor.black:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
