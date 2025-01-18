import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserDetailsPage extends StatelessWidget {
// final dynamic user;

  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.user_details,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: widthScreen * 0.06),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(widthScreen * 0.05),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(widthScreen * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.person,
                      color: Colors.blue, size: widthScreen * 0.08),
                  title: Text(appLocalizations.name,
                      style: TextStyle(
                          fontSize: widthScreen * 0.045, color: Colors.grey)),
                  subtitle: Text('John Doe',
                      style: TextStyle(
                          fontSize: widthScreen * 0.05,
                          fontWeight: FontWeight.bold)),
                  //user['name']
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.email,
                      color: Colors.blue, size: widthScreen * 0.08),
                  title: Text(appLocalizations.email,
                      style: TextStyle(
                          fontSize: widthScreen * 0.045, color: Colors.grey)),
                  subtitle: Text('john.doe@example.com',
                      style: TextStyle(
                          fontSize: widthScreen * 0.05,
                          fontWeight: FontWeight.bold)),
                  //user['email']
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.phone,
                      color: Colors.blue, size: widthScreen * 0.08),
                  title: Text(appLocalizations.phone,
                      style: TextStyle(
                          fontSize: widthScreen * 0.045, color: Colors.grey)),
                  subtitle: Text('123-456-7890',
                      style: TextStyle(
                          fontSize: widthScreen * 0.05,
                          fontWeight: FontWeight.bold)),
                  //user['phone']
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.person,
                      color: Colors.blue, size: widthScreen * 0.08),
                  title: Text(appLocalizations.gender,
                      style: TextStyle(
                          fontSize: widthScreen * 0.045, color: Colors.grey)),
                  subtitle: Text('Female',
                      style: TextStyle(
                          fontSize: widthScreen * 0.05,
                          fontWeight: FontWeight.bold)),
                  // user['gender']
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.cake,
                      color: Colors.blue, size: widthScreen * 0.08),
                  title: Text(appLocalizations.age,
                      style: TextStyle(
                          fontSize: widthScreen * 0.045, color: Colors.grey)),
                  subtitle: Text(
                    '23',
                    style: TextStyle(
                        fontSize: widthScreen * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                  //user['age']
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
