// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/gen/assets.gen.dart';
import 'package:todo_app/view_models/login_view_model.dart';
import 'package:todo_app/view_models/user_view_model.dart';
import 'widgets/login_widget.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final LoginController loginController = Get.find();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar("Login", false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 25.w, right: 25.w),
                margin: EdgeInsets.only(top: 66.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText("Email"),
                    SizedBox(height: 5.h),
                    textField(
                      "Enter your email address",
                      TextFieldType.email,
                      Assets.icons.user.image(),
                      loginController.emailLoginController,
                    ),
                    titleText("Password"),
                    SizedBox(height: 5.h),
                    textField(
                      "Enter your password",
                      TextFieldType.password,
                      Assets.icons.lock.image(),
                      loginController.passwordLoginController,
                    ),
                    Obx(() => isError(loginController.isEmpty.value)),
                  ],
                ),
              ),
              logInAndRegButton("Login", ButtonType.login,
                  () => loginController.loginAction(userController)),
              logInAndRegButton("Register", ButtonType.register,
                  loginController.actionGoToRegister)
            ],
          ),
        ),
      )),
    );
  }
}
