import 'package:get/get.dart';
import 'package:todo_app/database/user_database.dart';
import 'package:todo_app/models/user_model.dart';

class UserController extends GetxController {
  UserDatabase userDatabase = UserDatabase();
  var user = UserModel().obs;

  void updateUser(UserModel newUser) {
    user.value = newUser;
  }

  Future<bool> checkAndRegisterUser(UserModel user) async {
    final data = await userDatabase.getUserByUserName(user.userName);
    if (data != null) {
      Get.snackbar('Notify',
          'Username is already in use. please choose another username');
    } else {
      await addUser(user);
      Get.snackbar('Notify', 'Sign Up Success');
    }
    return data == null;
  }

  Future<bool> checkLoginUser(String userName, String password) async {
    final data = await userDatabase.getUserByUserName(userName);
    if (data != null && password == data.password) {
      Get.snackbar('Notify', 'Logged in successfully');
      updateUser(data);
    } else {
      Get.snackbar('Notify', 'Incorrect account or information');
    }
    return (data != null && password == data.password);
  }

  Future<void> addUser(UserModel user) async {
    await userDatabase.createUser(user);
  }

  // Future<void> updateUserstatus(UserModel user) async {
  //   await userDatabase.updateUserStatus(user);
  //   users.refresh();
  // }

  // Future<void> deleteUserItem(UserModel user) async {
  //   await userDatabase.deleteUser(user);
  //   users.remove(user);
  // }
}
