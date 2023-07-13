// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/database/todo_databases.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/view_models/user_view_model.dart';

class TodoController extends GetxController {
  final TodoDatabase todoDatabase = TodoDatabase();
  final RxList<TodoModel> todos = <TodoModel>[].obs;
  final TextEditingController contentController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final UserController userController = Get.find();

  @override
  void onInit() {
    refreshListTodo();
    super.onInit();
  }

  Future<void> refreshListTodo() async {
    final data =
        await todoDatabase.getTodosByUserId(userController.user.value.id);
    todos.assignAll(data);
  }

  Future<void> addTodo(int? userId, String title, String content) async {
    final newTodo = TodoModel(content: content, userId: userId, title: title);
    await todoDatabase.createTodo(newTodo);
    todos.add(newTodo);
  }

  Future<void> updateTodoStatus(TodoModel todo) async {
    await todoDatabase.updateTodoStatus(todo);
    todos.refresh();
  }

  Future<void> deleteTodoItem(TodoModel todo) async {
    await todoDatabase.deleteTodoById(todo.id);
    todos.remove(todo);
  }

  editTodoItemAction(BuildContext context, TodoModel? item) async {
    if (item == null) {
      await addTodo(userController.user.value.id, titleController.text.trim(),
          contentController.text.trim());
    } else {
      item.content = contentController.text.trim();
      item.title = titleController.text.trim();
      await updateTodoStatus(item);
    }
    Navigator.pop(context);
  }

  checkItemToDo(TodoModel? item) {
    if (item != null) {
      contentController.text = item.content ?? '';
      titleController.text = item.title ?? '';
    } else {
      contentController.clear();
      titleController.clear();
    }
  }
}
