import 'package:dio/dio.dart';
import 'package:users_management/model/UserModel.dart';

class UserService {
  final Dio dio;
  UserService(this.dio);

  Future<List<UserModel>> fetchUsers() async {
    try {
      Response response =
          await dio.get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        List<dynamic> users = response.data;
        List<UserModel> userList =
            users.map((user) => UserModel.fromJson(user)).toList();
        print(userList[0].name);
        return userList;
      } else {
        throw Exception('Failed to fetch employees: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch employees: $e');
    }
  }
}
