// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/gen/assets.gen.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/view_models/login_view_model.dart';
import 'package:todo_app/view_models/user_view_model.dart';
import 'widgets/login_widget.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextController textController = Get.put(TextController());
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar("Register", true),
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
                      textController.controllerEmailRegister,
                    ),
                    titleText("Password"),
                    SizedBox(height: 5.h),
                    textField(
                        "Enter your password",
                        TextFieldType.password,
                        Assets.icons.lock.image(),
                        textController.controllerPasswordRegister),
                    titleText("ConfirmPassword"),
                    SizedBox(height: 5.h),
                    textField(
                        "Confirm password",
                        TextFieldType.password,
                        Assets.icons.lock.image(),
                        textController.controllerConfirmPassword),
                    Obx(() => textController.errorText()),
                    Obx(() => textController.inCorrectText())
                  ],
                ),
              ),
              logInAndRegButton("Register", ButtonType.register, () async {
                if (textController.controllerEmailRegister.text.isEmpty ||
                    textController.controllerPasswordRegister.text.isEmpty ||
                    textController.controllerConfirmPassword.text.isEmpty) {
                  textController.isEmpty.value = true;
                } else {
                  textController.isEmpty.value = false;
                  if (textController.controllerPasswordRegister.text.trim() !=
                      textController.controllerConfirmPassword.text.trim()) {
                    textController.isCorrect.value = true;
                  } else {
                    textController.isCorrect.value = false;
                    UserModel userRegister = UserModel(
                        userName:
                            textController.controllerEmailRegister.text.trim(),
                        password: textController.controllerPasswordRegister.text
                            .trim());
                    var check = await userController.checkRegisterUser(
                        context, userRegister);
                    if (check) {
                      Get.back();
                      textController.clearText();
                    }
                  }
                }
              })
            ],
          ),
        ),
      )),
    );
  }
}
