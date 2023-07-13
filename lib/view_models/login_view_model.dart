import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/routers/app_routers.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/view_models/user_view_model.dart';

class LoginController extends GetxController {
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  RxBool isEmpty = false.obs;
  RxBool isCorrect = false.obs;
  bool isObscureText = true;

  void reverseObscure() {
    isObscureText = !isObscureText;
    update();
  }

  void clearText() {
    emailLoginController.clear();
    passwordLoginController.clear();
    emailRegisterController.clear();
    passwordRegisterController.clear();
    passwordConfirmController.clear();
  }

  loginAction(UserController userController) async {
    if (emailLoginController.text.isEmpty ||
        passwordLoginController.text.isEmpty) {
      isEmpty.value = true;
    } else {
      isEmpty.value = false;
      var check = await userController.checkLoginUser(
          emailLoginController.text.trim(),
          passwordLoginController.text.trim());
      if (check) {
        clearText();
        Get.toNamed(AppRouter.test);
      }
    }
  }

  actionGoToRegister() async {
    isEmpty.value = false;
    clearText();
    Get.toNamed(AppRouter.signUp);
  }

  registerAction(BuildContext context, UserController userController) async {
    if (emailRegisterController.text.isEmpty ||
        passwordRegisterController.text.isEmpty ||
        passwordConfirmController.text.isEmpty) {
      isEmpty.value = true;
    } else {
      isEmpty.value = false;
      if (passwordRegisterController.text.trim() !=
          passwordConfirmController.text.trim()) {
        isCorrect.value = true;
      } else {
        isCorrect.value = false;
        UserModel userRegister = UserModel(
            userName: emailRegisterController.text.trim(),
            password: passwordRegisterController.text.trim());
        var check = await userController.checkAndRegisterUser(userRegister);
        if (check) {
          Get.back();
          clearText();
        }
      }
    }
  }
}
