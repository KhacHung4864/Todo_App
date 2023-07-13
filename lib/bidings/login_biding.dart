import 'package:get/get.dart';
import 'package:todo_app/view_models/login_view_model.dart';
import 'package:todo_app/view_models/user_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => UserController());
  }
}
