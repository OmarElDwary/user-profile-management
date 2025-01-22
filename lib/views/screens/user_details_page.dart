import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users_management/models/user_model.dart';

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.user_details,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(widthScreen * 0.04),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(widthScreen * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: Text(
                    appLocalizations.name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  subtitle: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                  title: Text(
                    appLocalizations.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  subtitle: Text(
                    user.email,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                  title: Text(
                    appLocalizations.phone,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  subtitle: Text(
                    user.phone,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}