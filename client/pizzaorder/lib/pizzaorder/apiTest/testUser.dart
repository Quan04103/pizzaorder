import 'package:pizzaorder/pizzaorder/models/user.dart';

import '../services/user_service.dart';

//How to test this file by Quân
// D:\flutter\pizzaorder\client\pizzaorder\lib\pizzaorder\apiTest> dart run test.dart

void main() async {
  UserService userService = UserService();
  UserModel user = await userService.login('test123123', '123456');
  print('Received token: ${user.token}');
  print('Response status: ${user.status}');
  if (user.token != null) {
    UserModel userInfo = await userService.getUserInfo(user.token!);
    print('Username: ${userInfo.username}');
    print('Profile Name: ${userInfo.nameProfile}');
  }
}
