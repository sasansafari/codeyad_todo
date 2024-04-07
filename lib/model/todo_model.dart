import 'package:hive_flutter/hive_flutter.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel extends HiveObject {
  @HiveField(0)
  int id = -1;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  TodoColor color;

  TodoModel(
      {required this.title, required this.description, required this.color});
}

@HiveType(typeId: 1)
enum TodoColor {
  @HiveField(0)
  green(0xff7CC371),

  @HiveField(1)
  red(0xffF30D0D),

  @HiveField(2)
  blue(0xff170DF3),

  @HiveField(3)
  black(0xff000000);

  final int code;

  const TodoColor(this.code);
}
