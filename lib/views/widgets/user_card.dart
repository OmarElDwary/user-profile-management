// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../screens/edit_user.dart';
import '../screens/user_details_page.dart';
import 'delete_button.dart';
import 'edit_button.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.userModel,
    required this.usersList,
  });

  final UserModel userModel;
  final List<UserModel> usersList;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  void initState() {
    print(widget.usersList);
    super.initState();
  }

  final UserService userService = UserService(Dio());

  Future<void> deleteUser(int userId) async {
    try {
      print(userId);
      print("deleted");
      await userService.deleteUser(userId);
      print(userId);
      setState(() {
        widget.usersList.removeWhere((user) => user.id == userId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetailsPage(),
            ),
          );
        },
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
            title: Text(
              widget.userModel.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.userModel.email,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                EditButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(
                            // user: widget.user,
                            ),
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                DeleteButton(
                  onpressesd: () => deleteUser(widget.userModel.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
