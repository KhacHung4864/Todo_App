// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/app_theme/app_fonts.dart';
import 'package:todo_app/common/app_theme/app_theme.dart';
import 'package:todo_app/view_models/todo_view_model1.dart';
import 'package:todo_app/views/login/widgets/login_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TodoController todoController = Get.put(TodoController());

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
            todoController.editItem(context, null);
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
                onPressed: () => todoController.editItem(
                    context, todoController.todos[index]),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => todoController.deleteItem(
                    context, todoController.todos[index]),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
