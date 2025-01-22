import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users_management/views/widgets/user_card.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../screens/add_user.dart';

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
  Locale _locale = Locale('en');

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
      List<UserModel> users = await userService.loadCachedUsers();
      setState(() {
        usersList = users;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
              color: Colors.white),
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
                value: Locale('en'),
                child: Text(appLocalizations.english),
              ),
              DropdownMenuItem(
                value: Locale('ar'),
                child: Text(appLocalizations.arabic),
              ),
            ],
            underline: const SizedBox(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: usersList.length,
        itemBuilder: (context, index) {
          final user = usersList[index];
          return UserCard(
            userModel: user,
            usersList: usersList,
            onUserDelete: () {
              setState(() {
                usersList.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(
                usersList: usersList,
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        splashColor: Colors.blue[200],
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
