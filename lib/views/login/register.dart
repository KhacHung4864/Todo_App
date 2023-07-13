import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/gen/assets.gen.dart';
import 'package:todo_app/view_models/login_view_model.dart';
import 'package:todo_app/view_models/user_view_model.dart';
import 'widgets/login_widget.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final LoginController textController = Get.find();
  final UserController userController = Get.find();

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
                      textController.emailRegisterController,
                    ),
                    titleText("Password"),
                    SizedBox(height: 5.h),
                    textField(
                      "Enter your password",
                      TextFieldType.password,
                      Assets.icons.lock.image(),
                      textController.passwordRegisterController,
                    ),
                    titleText("ConfirmPassword"),
                    SizedBox(height: 5.h),
                    textField(
                      "Confirm password",
                      TextFieldType.password,
                      Assets.icons.lock.image(),
                      textController.passwordConfirmController,
                    ),
                    Obx(() => isError(textController.isEmpty.value)),
                    Obx(() => inCorrectText(textController.isCorrect.value))
                  ],
                ),
              ),
              logInAndRegButton("Register", ButtonType.register,
                  () => textController.registerAction(context, userController))
            ],
          ),
        ),
      )),
    );
  }
}
