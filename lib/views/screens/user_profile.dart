import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_profile/views/screens/add_user.dart';
import 'package:user_profile/views/widgets/delete_button.dart';
import 'package:user_profile/views/screens/edit_user.dart';
import 'package:user_profile/views/widgets/edit_button.dart';

import 'user_details_page.dart';

class UsersProfile extends StatefulWidget {
  final Function(Locale) changeLanguage;

  const UsersProfile({super.key, required this.changeLanguage});

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

  // List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
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
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(
                horizontal: widthScreen * 0.03,
                vertical: heightScreen * 0.01,
              ),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsPage(),
                      ),
                    );
                  },
                  child: Padding(
                      padding: EdgeInsets.all(widthScreen * 0.03),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(
                            Icons.person,
                            size: widthScreen * 0.06,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text('User ${index + 1}',
                            style: TextStyle(
                                fontSize: widthScreen * 0.05,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text('Email ${index + 1} ',
                            style: TextStyle(
                              fontSize: widthScreen * 0.04,
                              color: Colors.grey[600],
                            )),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            EditButton(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditUserPage(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: widthScreen * 0.02),
                            DeleteButton(),
                          ],
                        ),
                      ))));
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(),
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
