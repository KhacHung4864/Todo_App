import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/common/routers/app_routers.dart';
import 'package:todo_app/common/widgets/keyboard_dismiss.dart';
import 'package:todo_app/views/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => KeyboardDismiss(
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  elevation: 0, backgroundColor: Colors.white)),
          home: Login(),
          getPages: AppRouter.route,
          initialRoute: '/',
        ),
      ),
    );
  }
}
