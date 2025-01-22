import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:users_management/models/user_model.dart';
import 'package:users_management/services/user_service.dart';
import 'package:users_management/views/screens/edit_user.dart';
import 'package:users_management/views/screens/user_details_page.dart';
import 'package:users_management/views/widgets/delete_button.dart';
import 'package:users_management/views/widgets/edit_button.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.userModel,
    required this.onUserDelete,
    required this.onUserUpdated,
  });

  final UserModel userModel;
  final VoidCallback onUserDelete;
  final Function(UserModel) onUserUpdated;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final UserService userService = UserService(Dio());

  Future<void> deleteUser(int userId) async {
    try {
      await userService.deleteUser(userId);
      widget.onUserDelete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
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
              builder: (context) => UserDetailsPage(
                user: widget.userModel,
              ),
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
              style: const TextStyle(
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
                    final updatedUser = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserPage(
                          user: widget.userModel,
                        ),
                      ),
                    );

                    if (updatedUser != null) {
                      widget.onUserUpdated(updatedUser);
                    }
                  },
                ),
                const SizedBox(width: 10),
                DeleteButton(
                  onPressed: () => deleteUser(widget.userModel.id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}