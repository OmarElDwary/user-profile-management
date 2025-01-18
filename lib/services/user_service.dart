import 'package:dio/dio.dart';
import '../models/user_model.dart';

class UserService {
  final Dio dio;
  UserService(this.dio);
  final String baseUrl = 'https://jsonplaceholder.typicode.com/users/';

  Future<List<UserModel>> fetchUsers() async {
    try {
      Response response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        List<dynamic> users = response.data;
        List<UserModel> userList =
            users.map((user) => UserModel.fromJson(user)).toList();
        return userList;
      } else {
        throw Exception('Failed to fetch employees: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch employees: $e');
    }
  }

  Future<bool> deleteUser(int userId) async {
    try {
      Response response =
          await dio.delete(Uri.parse('$baseUrl$userId').toString());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    try {
      Response response = await dio.post(baseUrl, data: user.toJson());
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      Response response =
          await dio.put('$baseUrl${user.id}', data: user.toJson());
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to update user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }
}
