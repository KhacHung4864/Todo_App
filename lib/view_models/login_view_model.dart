import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/app_theme/app_fonts.dart';
import '../common/app_theme/app_theme.dart';

class ObscureController extends GetxController {
  RxBool isObscureText = true.obs;
  void reverseObscure() {
    isObscureText.value = !isObscureText.value;
  }
}

class TextController extends GetxController {
  final controllerEmailLogin = TextEditingController();
  final controllerPasswordLogin = TextEditingController();
  final controllerEmailRegister = TextEditingController();
  final controllerPasswordRegister = TextEditingController();
  final controllerConfirmPassword = TextEditingController();
  RxBool isEmpty = false.obs;
  RxBool isCorrect = false.obs;

  void clearText() {
    controllerEmailLogin.clear();
    controllerPasswordLogin.clear();
    controllerEmailRegister.clear();
    controllerPasswordRegister.clear();
    controllerConfirmPassword.clear();
  }

  errorText() {
    return isEmpty.value
        ? Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text("Value Can't Be Empty",
                style: AppFonts.avenir400(12.sp, AppColors.primaryElementBg)),
          )
        : SizedBox(
            height: 15.h,
          );
  }

  inCorrectText() {
    return isCorrect.value
        ? Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Text("Password incorrect",
                style: AppFonts.avenir400(12.sp, AppColors.primaryElementBg)),
          )
        : SizedBox(
            height: 15.h,
          );
  }
}
