import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users_management/models/user_model.dart';

class UserDetailsPage extends StatelessWidget {
// final dynamic user;
  UserModel user;
  UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.user_details,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.85),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(0.85),
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text(appLocalizations.name,
                        style: TextStyle(color: Colors.grey)),
                    subtitle: Text(user.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    //user['name']
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    title: Text(appLocalizations.email,
                        style: TextStyle(color: Colors.grey)),
                    subtitle: Text(user.email,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    //user['email']
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    title: Text(appLocalizations.phone,
                        style: TextStyle(color: Colors.grey)),
                    subtitle: Text(user.phone,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    //user['phone']
                  ),
                  /*
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    title: Text(appLocalizations.gender,
                        style: TextStyle(color: Colors.grey)),
                    subtitle: Text('Female',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    // user['gender']
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.cake, color: Colors.blue),
                    title: Text(appLocalizations.age,
                        style: TextStyle(color: Colors.grey)),
                    subtitle: Text(
                      '23',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //user['age']
                  ),
                  */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
