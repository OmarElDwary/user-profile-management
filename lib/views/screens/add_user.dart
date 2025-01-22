import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../models/user_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AddUser extends StatefulWidget {
  final Function(UserModel)? onUserAdded;
  final List<UserModel> usersList;

  const AddUser({
    super.key,
    required this.usersList,
    this.onUserAdded,
  });

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _addUser() {
    if (_formKey.currentState!.validate()) {
      final newUser = UserModel(
        id: widget.usersList.isEmpty ? 1 : widget.usersList.last.id + 1,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      if (widget.onUserAdded != null) {
        widget.onUserAdded!(newUser);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.addUser,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(widthScreen * 0.05),
        child: Form(
          key: _formKey,
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
                text: appLocalizations.addUser,
                icon: Icons.person_add,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                onPressed: _addUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}