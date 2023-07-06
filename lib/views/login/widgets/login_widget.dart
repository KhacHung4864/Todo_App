import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/app_theme/app_fonts.dart';
import 'package:todo_app/common/app_theme/app_theme.dart';
import 'package:todo_app/view_models/login_view_model.dart';

AppBar appBar(String title, bool isBack) {
  return AppBar(
    backgroundColor: AppColors.primaryElement,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title,
            style: AppFonts.avenir400(
                20.sp, AppColors.primarySecondaryBackground)),
        isBack
            ? SizedBox(
                width: 50.w,
              )
            : const SizedBox.shrink()
      ],
    ),
    automaticallyImplyLeading: isBack,
  );
}

Widget titleText(String text) {
  return Container(
      margin: EdgeInsets.only(top: 5.h),
      child: Text(
        text,
        style: AppFonts.avenir400(14.sp, AppColors.primaryFourElementText),
      ));
}

enum TextFieldType { password, email }

Widget textField(
  String hintext,
  TextFieldType textFieldType,
  Image image,
  TextEditingController textController,
) {
  final ObscureController obsController = Get.put(ObscureController());
  final TextController checkController = Get.put(TextController());
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: AppColors.primaryFourElementText)),
    child: Row(children: [
      Container(margin: EdgeInsets.only(left: 17.w), width: 16.w, child: image),
      SizedBox(
        width: 270.w,
        child: textFieldType == TextFieldType.email
            ? Center(
                child: TextFormField(
                  onTap: () {
                    checkController.isEmpty.value = false;
                  },
                  controller: textController,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: hintext,
                    hintStyle: const TextStyle(
                      color: AppColors.primarySecondaryElementText,
                    ),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  style: AppFonts.avenir400(14.sp, AppColors.primaryText),
                ),
              )
            : Obx(
                () => Center(
                  child: TextFormField(
                    onTap: () {
                      checkController.isEmpty.value = false;
                      checkController.isCorrect.value = false;
                    },
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    autocorrect: false,
                    obscureText: obsController.isObscureText.value,
                    decoration: InputDecoration(
                      suffixIcon: textFieldType == TextFieldType.password
                          ? Padding(
                              padding: EdgeInsets.only(right: 15.w),
                              child: GestureDetector(
                                onTap: () {
                                  obsController.reverseObscure();
                                },
                                child: Icon(
                                  obsController.isObscureText.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.primaryText,
                                  size: 20.w,
                                ),
                              ),
                            )
                          : null,
                      hintText: hintext,
                      hintStyle: const TextStyle(
                        color: AppColors.primarySecondaryElementText,
                      ),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                    ),
                    style: AppFonts.avenir400(14.sp, AppColors.primaryText),
                  ),
                ),
              ),
      ),
    ]),
  );
}

enum ButtonType { login, register }

Widget logInAndRegButton(
    String buttonName, ButtonType buttonType, Function() ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      margin: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
          top: buttonType == ButtonType.login ? 40.h : 20.h),
      decoration: BoxDecoration(
          color: buttonType == ButtonType.login
              ? AppColors.primaryElement
              : AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(
              color: buttonType == ButtonType.login
                  ? Colors.transparent
                  : AppColors.primaryFourElementText),
          boxShadow: const [
            BoxShadow(
                color: AppColors.primarySecondaryBackground,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1))
          ]),
      child: Center(
          child: Text(
        buttonName,
        style: AppFonts.avenir400(
          16.sp,
          buttonType == ButtonType.login
              ? AppColors.primaryBackground
              : AppColors.primaryText,
        ),
      )),
    ),
  );
}
