// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/widgets/show_dialog_widget.dart';
import 'package:todo_app/database/todo_databases.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/view_models/user_view_model.dart';

class TodoController extends GetxController {
  final TodoDatabase todoDatabase = TodoDatabase();
  final RxList<TodoModel> todos = <TodoModel>[].obs;
  final TextEditingController contentController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  void onInit() {
    refreshListTodo();
    super.onInit();
  }

  Future<void> refreshListTodo() async {
    final data = await todoDatabase.getTodosByUser(userController.user.value);
    todos.assignAll(data);
  }

  Future<void> addTodo(int? userId, String title, String content) async {
    final newTodo = TodoModel(content: content, userId: userId, title: title);
    await todoDatabase.createTodos(newTodo);
    todos.add(newTodo);
  }

  Future<void> updateTodoStatus(TodoModel todo) async {
    await todoDatabase.updateTodoStatus(todo);
    todos.refresh();
  }

  Future<void> deleteTodoItem(TodoModel todo) async {
    await todoDatabase.deleteTodo(todo);
    todos.remove(todo);
  }

  void deleteItem(BuildContext context, TodoModel item) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(child: Text("Delete this item?")),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () async {
                    await deleteTodoItem(item);
                    Navigator.pop(context);
                    mySnackBar(
                        context: context, content: 'Delete successfully');
                  },
                ),
              ],
            ));
  }

  void editItem(BuildContext context, TodoModel? item) {
    if (item != null) {
      contentController.text = item.content ?? '';
      titleController.text = item.title ?? '';
    } else {
      contentController.clear();
      titleController.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Enter todo title',
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: 'Enter todo content',
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(item == null ? 'Add' : 'Update'),
            onPressed: () async {
              if (item == null) {
                await addTodo(userController.user.value.id,
                    titleController.text.trim(), contentController.text.trim());
              } else {
                item.content = contentController.text.trim();
                item.title = titleController.text.trim();
                await updateTodoStatus(item);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
