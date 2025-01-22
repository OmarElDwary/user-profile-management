import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users_management/models/user_model.dart';
import 'package:users_management/views/widgets/custom_button.dart';
import 'package:users_management/views/widgets/custom_text_field.dart';

class EditUserPage extends StatefulWidget {
  UserModel user;
  final Function(UserModel)? onUserUpdated;

  EditUserPage({super.key, required this.user, this.onUserUpdated});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _updateUser() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context)!.please_fill_all_fields)),
      );
      return;
    }

    final updatedUser = UserModel(
      id: widget.user.id,
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
    );

    if (widget.onUserUpdated != null) {
      widget.onUserUpdated!(updatedUser);
    }

    Navigator.pop(context, updatedUser);
  }
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.editUser,
          style: TextStyle(
              fontSize: widthScreen * 0.06, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(widthScreen * 0.05),
        child: ListView(
          children: [
            CustomTextField(
              labelText: appLocalizations.name,
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.please_enter_a_name;
                }
                return null;
              },
            ),
            SizedBox(height: heightScreen * 0.02),
            CustomTextField(
              labelText: appLocalizations.email,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.please_enter_an_email;
                } else if (!value.contains('@')) {
                  return appLocalizations.please_enter_a_valid_email;
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: heightScreen * 0.02),
            CustomTextField(
              labelText: appLocalizations.phone,
              controller: _phoneController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.please_enter_a_phone_number;
                } else if (value.length < 10) {
                  return appLocalizations
                      .phone_number_must_be_at_least_10_digits;
                }
                return null;
              },
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: heightScreen * 0.03),
            CustomButton(
              text: appLocalizations.update_user,
              icon: Icons.save,
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              onPressed: _updateUser,
            ),
          ],
        ),
      ),
    );
  }
}
