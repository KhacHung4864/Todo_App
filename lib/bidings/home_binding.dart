import 'package:get/get.dart';
import 'package:todo_app/view_models/todo_view_model1.dart';

class HomeBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TodoController());
  }
}
