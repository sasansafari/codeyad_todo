import 'package:codeyad_todo/main_screen.dart';
import 'package:codeyad_todo/model/todo_model.dart';
import 'package:flutter/material.dart';

late TodoColor _selectedColor;

class TodoFormScreen extends StatelessWidget {
  TodoFormScreen({super.key, required this.todoModel});

  TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    _selectedColor = todoModel.color;
    final titleController = TextEditingController(text: todoModel.title);
    final descController = TextEditingController(text: todoModel.description);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Todo Form"),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const _TodoColorSelector(),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: titleController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: descController,
              textInputAction: TextInputAction.newline,
              maxLines: 8,
              decoration: const InputDecoration(hintText: "Description"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: const Text("please complete all the fields")));
          } else {
            todoModel.title = titleController.text.trim();
            todoModel.description = descController.text.trim();
            todoModel.color = _selectedColor;

            if (todoModel.isInBox) {
              todoModel.save();
            } else {
              box.add(todoModel);
            }

            Navigator.pop(context);
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: const Icon(Icons.save),
      ),
    ));
  }
}

class _TodoColorSelector extends StatefulWidget {
  const _TodoColorSelector({super.key});

  @override
  State<_TodoColorSelector> createState() => __TodoColorSelectorState();
}

class __TodoColorSelectorState extends State<_TodoColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColorItem(
            onTap: () => setState(() => _selectedColor = TodoColor.blue),
            isSelected: _selectedColor == TodoColor.blue,
            colorCode: TodoColor.blue.code),
        ColorItem(
            onTap: () => setState(() => _selectedColor = TodoColor.black),
            isSelected: _selectedColor == TodoColor.black,
            colorCode: TodoColor.black.code),
        ColorItem(
            onTap: () => setState(() => _selectedColor = TodoColor.green),
            isSelected: _selectedColor == TodoColor.green,
            colorCode: TodoColor.green.code),
        ColorItem(
            onTap: () => setState(() => _selectedColor = TodoColor.red),
            isSelected: _selectedColor == TodoColor.red,
            colorCode: TodoColor.red.code),
      ],
    );
  }
}

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.colorCode,
  });

  final Function() onTap;
  final bool isSelected;
  final int colorCode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(3),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Color(colorCode)),
        child: isSelected
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
