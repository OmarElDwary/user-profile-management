import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_profile/presentation/widgets/custom_button.dart';
import 'package:user_profile/presentation/widgets/custom_drop_down_field.dart';
import 'package:user_profile/presentation/widgets/custom_text_field.dart';

class EditUserPage extends StatefulWidget {
  // final dynamic user;

  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final List<String> _genderOptions = ['Male', 'Female'];
  String? _selectedGender;

  final List<String> _ageOptions =
      List.generate(83, (index) => (index + 18).toString());
  String? _selectedAge;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    // _nameController = TextEditingController(text: "widget.user['name']");
    // _emailController = TextEditingController(text: "widget.user['email']");
    // _phoneController = TextEditingController(text: "widget.user['phone']");
    // _selectedGender = widget.user['gender'];
    // _selectedAge = widget.user['age'];
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

    final updatedUser = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'gender': _selectedGender,
      'age': _selectedAge,
    };

    print('Updated User: $updatedUser');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(AppLocalizations.of(context)!.user_updated_successfully)),
    );

    // api hyb2a hena
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
            SizedBox(height: heightScreen * 0.02),
            CustomDropdownField(
              labelText: appLocalizations.gender,
              value: _selectedGender,
              items: _genderOptions,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.please_select_a_gender;
                }
                return null;
              },
            ),
            SizedBox(height: heightScreen * 0.02),
            CustomDropdownField(
              labelText: 'Age',
              value: _selectedAge,
              items: _ageOptions,
              onChanged: (value) {
                setState(() {
                  _selectedAge = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.please_select_an_age;
                }
                return null;
              },
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
