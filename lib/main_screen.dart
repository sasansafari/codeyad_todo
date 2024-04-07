import 'package:codeyad_todo/main.dart';
import 'package:codeyad_todo/model/todo_model.dart';
import 'package:codeyad_todo/todo_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

final box = Hive.box<TodoModel>(todoBox);

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("TODOs"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoFormScreen(
                            todoModel: TodoModel(
                                title: "",
                                description: '',
                                color: TodoColor.blue))));
              },
              icon: const Icon(Icons.add_circle_rounded))
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "My ToDo Items",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
              child: ValueListenableBuilder<Box<TodoModel>>(
                  valueListenable: box.listenable(),
                  builder: (context, todoBox, child) {
                    final todoList = todoBox.values.toList();

                    if (todoList.isEmpty) {
                      //TODO ui
                      return const Text("Empty");
                    } else {
                      return ListView.builder(
                          itemCount: todoList.length,
                          itemBuilder: (context, index) {
                            todoList[index].id = box.keyAt(index);
                            return TodoItem(todo: todoList[index]);
                          });
                    }
                  })),
        ],
      ),
    ));
  }
}

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final TodoModel todo;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(todo.description),
          backgroundColor: Colors.black,
          action: SnackBarAction(
              label: "Edit",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoFormScreen(todoModel: todo)));
              }),
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Dismissible(
            key: ValueKey<int>(todo.id),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                box.delete(todo.id);
              }
            },
            confirmDismiss: (direction) async =>
                direction == DismissDirection.endToStart,
            dismissThresholds: const {DismissDirection.endToStart: 0.3},
            background: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.red,
              child: const Icon(Icons.delete),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.edit_note,
                          size: 24,
                          color: Color(todo.color.code),
                        ),
                      ),
                      Text(
                        todo.title,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(todo.color.code)),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Text(
                      todo.description,
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider()
                ],
              ),
            )),
      ),
    );
  }
}
