import 'dart:io';

import 'package:codeyad_todo/main_screen.dart';
import 'package:codeyad_todo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

const String todoBox = 'todo-box';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive
    ..registerAdapter(TodoModelAdapter())
    ..registerAdapter(TodoColorAdapter());

  await Hive.openBox<TodoModel>(todoBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(centerTitle: true),
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.black12),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.blue.withOpacity(.5)))),
      ),
      home: MainScreen(),
    );
  }
}
