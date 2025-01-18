import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_management/models/user_model.dart';
import 'package:users_management/services/user_service.dart';

class DataHandling {
  List<UserModel> users = [];
  final Dio dio;
  DataHandling(this.dio);
  final String baseUrl = 'https://jsonplaceholder.typicode.com/users/';

  Future<void> addUser(UserModel newUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //we should invoke Post request from the User Service? but won't work because it's a dummy API :(

    // unique Id for the new user
    final int newId = (users.isNotEmpty ? users.length + 1 : 1);
    newUser = UserModel(
        id: newId,
        name: newUser.name,
        email: newUser.email,
        phone: newUser.phone);
    // Add the newUser and update cache
    users.add(newUser);
    final String updatedData =
        jsonEncode(users.map((e) => e.toJson()).toList());
    prefs.setString('usersData', updatedData);
  }

  Future<void> updateUser(UserModel updatedUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //we should invoke Put request from the User Service? but won't work because it's a dummy API :(

    //find the updated user
    final int index = users.indexWhere((user) => user.id == updatedUser.id);
    //if the user found update it
    if (index != -1) {
      users[index] = updatedUser;

      // Add the update the user and update cache
      final String updatedData =
          jsonEncode(users.map((e) => e.toJson()).toList());
      prefs.setString('usersData', updatedData);
    }
  }

  Future<void> deleteUser(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //we should invoke Delete request from the User Service? but won't work because it's a dummy API
    // Remove the user from the list
    users.removeWhere((user) => user.id == id);
    // then update the cached list of Users
    final String updatedData =
        jsonEncode(users.map((user) => user.toJson()).toList());
    prefs.setString('usersData', updatedData);
  }
}
