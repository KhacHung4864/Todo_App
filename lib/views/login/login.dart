// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/routers/app_routers.dart';
import 'package:todo_app/gen/assets.gen.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/view_models/login_view_model.dart';
import 'package:todo_app/view_models/user_view_model.dart';
import 'widgets/login_widget.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextController textController = Get.put(TextController());
  final UserController userController = Get.put(UserController());
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
                        textController.controllerEmailLogin),
                    titleText("Password"),
                    SizedBox(height: 5.h),
                    textField(
                        "Enter your password",
                        TextFieldType.password,
                        Assets.icons.lock.image(),
                        textController.controllerPasswordLogin),
                    Obx(() => textController.errorText())
                  ],
                ),
              ),
              logInAndRegButton("Login", ButtonType.login, () async {
                if (textController.controllerEmailLogin.text.isEmpty ||
                    textController.controllerPasswordLogin.text.isEmpty) {
                  textController.isEmpty.value = true;
                } else {
                  textController.isEmpty.value = false;
                  UserModel userLogin = UserModel(
                      userName: textController.controllerEmailLogin.text.trim(),
                      password:
                          textController.controllerPasswordLogin.text.trim());
                  var check = await userController.checkLoginUser(
                      context,
                      userLogin,
                      textController.controllerPasswordLogin.text.trim());
                  if (check) {
                    textController.clearText();
                    Get.toNamed(AppRouter.test);
                  }
                }
              }),
              logInAndRegButton("Register", ButtonType.register, () {
                textController.isEmpty.value = false;
                textController.clearText();
                Get.toNamed(AppRouter.signUp);
              })
            ],
          ),
        ),
      )),
    );
  }
}
