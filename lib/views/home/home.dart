// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/app_theme/app_fonts.dart';
import 'package:todo_app/common/app_theme/app_theme.dart';
import 'package:todo_app/common/widgets/show_dialog_widget.dart';
import 'package:todo_app/models/todo_models.dart';
import 'package:todo_app/view_models/todo_view_model1.dart';
import 'package:todo_app/views/login/widgets/login_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TodoController todoController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Todos", false),
      body: Obx(
        () => ListView.builder(
          itemCount: todoController.todos.length,
          itemBuilder: (context, index) => _items(index, context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            editTodoItem(context, null);
          }),
    );
  }

  Card _items(int index, BuildContext context) {
    return Card(
      color: AppColors.itemBakcground,
      margin: EdgeInsets.all(15.w),
      child: ListTile(
        title: Text(
          todoController.todos[index].title ?? "",
          style: AppFonts.avenir500(
            16.sp,
            AppColors.primaryText,
          ),
        ),
        subtitle: Text(
          todoController.todos[index].content ?? "",
          style: AppFonts.avenir400(
            14.sp,
            AppColors.primary_bg,
          ),
        ),
        trailing: SizedBox(
          width: 100.w,
          child: Row(
            children: [
              IconButton(
                onPressed: () =>
                    editTodoItem(context, todoController.todos[index]),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () =>
                    deleteItem(context, todoController.todos[index]),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
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
                    await todoController.deleteTodoItem(item);
                    Navigator.pop(context);
                    Get.snackbar('Notify', 'Delete successfully');
                    // showNotifi(
                    //     context: context, content: 'Delete successfully');
                  },
                ),
              ],
            ));
  }

  void editTodoItem(BuildContext context, TodoModel? item) {
    todoController.checkItemToDo;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: todoController.titleController,
              decoration: const InputDecoration(
                hintText: 'Enter todo title',
              ),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: todoController.contentController,
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
              onPressed: () => todoController.editTodoItemAction(context, item),
              child: Text(item == null ? 'Add' : 'Update')),
        ],
      ),
    );
  }
}
