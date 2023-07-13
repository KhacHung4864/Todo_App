import 'package:get/get.dart';
import 'package:todo_app/view_models/login_view_model.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.delete<LoginController>();
    Get.lazyPut(() => LoginController());
  }
}
