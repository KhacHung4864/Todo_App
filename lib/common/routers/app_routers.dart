import 'package:get/get.dart';
import 'package:todo_app/views/home/home.dart';

import 'package:todo_app/views/login/login.dart';
import 'package:todo_app/views/login/register.dart';

class AppRouter {
  static final route = [
    GetPage(name: '/', page: () => Login()),
    GetPage(name: '/signUp', page: () => SignUp()),
    GetPage(name: '/test', page: () => HomeScreen()),
  ];

  static const signIn = '/';
  static const signUp = '/signUp';
  static const test = '/test';
}
