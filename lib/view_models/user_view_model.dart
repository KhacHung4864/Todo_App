// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/widgets/show_dialog_widget.dart';
import 'package:todo_app/database/user_database.dart';
import 'package:todo_app/models/user_model.dart';

class UserController extends GetxController {
  UserDatabase userDatabase = UserDatabase();
  var user = UserModel().obs;

  void updateUser(UserModel newUser) {
    user.value = newUser;
  }

  Future<bool> checkRegisterUser(BuildContext context, UserModel user) async {
    final data = await userDatabase.getUser(user);
    if (data.isNotEmpty) {
      mySnackBar(
          context: context,
          content:
              'Username is already in use. please choose another username');
    } else {
      await addUser(user);
      mySnackBar(context: context, content: 'Sign Up Success');
    }
    return data.isEmpty;
  }

  Future<bool> checkLoginUser(
      BuildContext context, UserModel user, String password) async {
    final data = await userDatabase.getUser(user);
    if (data.isNotEmpty && password == data.first.password) {
      mySnackBar(context: context, content: 'Logged in successfully');
      updateUser(data.first);
    } else {
      mySnackBar(context: context, content: 'Incorrect account or information');
    }
    return (data.isNotEmpty && password == data.first.password);
  }

  Future<void> addUser(UserModel user) async {
    await userDatabase.createUsers(user);
  }

  // Future<void> updateUserstatus(UserModel user) async {
  //   await userDatabase.updateUserStatus(user);
  //   users.refresh();
  // }

  // Future<void> deleteUserItem(UserModel user) async {
  //   await userDatabase.deleteUser(user);
  //   users.remove(user);
  // }
}
