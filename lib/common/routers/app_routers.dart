import 'package:get/get.dart';
import 'package:todo_app/bidings/home_binding.dart';
import 'package:todo_app/bidings/login_biding.dart';
import 'package:todo_app/bidings/register_binding.dart';
import 'package:todo_app/views/home/home.dart';

import 'package:todo_app/views/login/login.dart';
import 'package:todo_app/views/login/register.dart';

class AppRouter {
  static final route = [
    GetPage(name: '/', page: () => Login(), binding: LoginBinding()),
    GetPage(name: '/signUp', page: () => SignUp(), binding: RegisterBinding()),
    GetPage(name: '/test', page: () => HomeScreen(), binding: HomeBiding()),
  ];

  static const signIn = '/';
  static const signUp = '/signUp';
  static const test = '/test';
}
