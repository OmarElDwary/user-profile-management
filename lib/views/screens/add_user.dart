import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users_management/data/data_handling.dart';
import 'package:users_management/models/user_model.dart';
import 'package:users_management/services/user_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down_field.dart';
import '../widgets/custom_text_field.dart';

class AddUser extends StatefulWidget {
  const AddUser({
    super.key,
    required this.usersList,
  });
  final List<UserModel> usersList;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final UserService userService = UserService(Dio());
  final List<String> _genderOptions = ['Male', 'Female'];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> createUser(UserModel newUser) async {
    if (!_formKey.currentState!.validate()) {
      try {
        UserModel newUser = UserModel(
          id: widget.usersList.length +
              1, // You might want to change this logic based on actual user ID management
          name: _nameController.text, // Access the text from the controller
          email: _emailController.text,
          phone: _phoneController.text,
        );
        await userService.createUser(newUser);
        setState(() {
          widget.usersList.add(newUser);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User created successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addUser,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(widthScreen * 0.05),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.name,
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_a_name;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: heightScreen * 0.02),
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.email,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_an_email;
                      } else if (!value.contains('@')) {
                        return AppLocalizations.of(context)!
                            .please_enter_a_valid_email;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: heightScreen * 0.02),
                  CustomTextField(
                    labelText: AppLocalizations.of(context)!.phone,
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .please_enter_a_phone_number;
                      } else if (value.length < 10) {
                        return AppLocalizations.of(context)!
                            .phone_number_must_be_at_least_10_digits;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: heightScreen * 0.03),
                  CustomButton(
                    text: AppLocalizations.of(context)!.addUser,
                    icon: Icons.person_add,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    onPressed: () => createUser(
                      UserModel(
                        id: widget.usersList.length + 1,
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
