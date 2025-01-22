import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users_management/models/user_model.dart';
import 'package:users_management/services/user_service.dart';
import 'package:users_management/views/screens/add_user.dart';
import 'package:users_management/views/widgets/user_card.dart';

class UsersProfile extends StatefulWidget {
  final Function(Locale) changeLanguage;

  const UsersProfile({
    super.key,
    required this.changeLanguage,
  });

  @override
  State<UsersProfile> createState() => _UsersProfileState();
}

class _UsersProfileState extends State<UsersProfile> {
  Locale _locale = const Locale('en');

  void _changeLanguage(Locale? locale) {
    if (locale != null) {
      setState(() {
        _locale = locale;
      });
      widget.changeLanguage(locale);
    }
  }

  final UserService userService = UserService(Dio());
  List<UserModel> usersList = [];
  bool isLoading = false;

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
    });
    try {
      final List<UserModel> users = await userService.loadCachedUsers();
      setState(() {
        usersList = users;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load users: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _addUser(UserModel newUser) async {
    setState(() {
      usersList.add(newUser);
    });
    await userService.cacheUsers(usersList);
    log('User added: ${newUser.name}');
  }

  Future<void> _updateUser(UserModel updatedUser) async {
    setState(() {
      final index = usersList.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        usersList[index] = updatedUser;
      }
    });
    await userService.cacheUsers(usersList);
    log('User updated: ${updatedUser.name}');
  }

  Future<void> _deleteUser(int userId) async {
    setState(() {
      usersList.removeWhere((user) => user.id == userId);
    });
    await userService.cacheUsers(usersList);
    log('User deleted: $userId');
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.usersApp,
          style: TextStyle(
            fontSize: widthScreen * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 4,
        centerTitle: true,
        actions: [
          DropdownButton<Locale>(
            icon: const Icon(Icons.language, color: Colors.white),
            onChanged: _changeLanguage,
            items: [
              DropdownMenuItem(
                value: const Locale('en'),
                child: Text(appLocalizations.english),
              ),
              DropdownMenuItem(
                value: const Locale('ar'),
                child: Text(appLocalizations.arabic),
              ),
            ],
            underline: const SizedBox(),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: usersList.length,
        itemBuilder: (context, index) {
          final user = usersList[index];
          return UserCard(
            userModel: user,
                  onUserDelete: () => _deleteUser(user.id),
                  onUserUpdated: _updateUser,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () async {
          final newUser = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(
                usersList: usersList,
                onUserAdded: _addUser,
              ),
            ),
          );

          if (newUser != null) {
            await _addUser(newUser);
          }
        },
        backgroundColor: Colors.blue,
        splashColor: Colors.blue[200],
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}