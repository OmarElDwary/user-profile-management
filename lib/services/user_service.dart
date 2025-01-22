import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {
  final Dio dio;
  UserService(this.dio);
  final String baseUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> fetchUsers() async {
    try {
      Response response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        List<dynamic> users = response.data;
        return users.map((user) => UserModel.fromJson(user)).toList();
      } else {
        throw Exception('Failed to fetch employees: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to fetch employees: $e');
    }
  }

  Future<void> cacheUsers(List<UserModel> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedData = jsonEncode(users.map((user) => user.toJson()).toList());
    await prefs.setString('usersData', cachedData);
  }

  Future<List<UserModel>> loadCachedUsers() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString('usersData');
      if (cachedData != null) {
        List<dynamic> jsonData = jsonDecode(cachedData);
        return jsonData.map((user) => UserModel.fromJson(user)).toList();
      } else {
        return await fetchUsers();
      }
    } catch (e) {
      throw Exception('Failed to load cached users: $e');
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      Response response = await dio.delete('$baseUrl/$userId');
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('user_$userId');
      } else {
        throw Exception('Failed to delete user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
