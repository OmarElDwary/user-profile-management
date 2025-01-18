import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:users_management/data/data_handling.dart';
import 'package:users_management/models/user_model.dart';
import 'package:users_management/services/userServices.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down_field.dart';
import '../widgets/custom_text_field.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<UserModel> usersList = [];
  final UserService userService = UserService(Dio());

  final List<String> _genderOptions = ['Male', 'Female'];
  String? _selectedGender;

  final List<String> _ageOptions =
      List.generate(83, (index) => (index + 18).toString());
  String? _selectedAge;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> storeUser() async {
    final newUser = UserModel(
      id: 0,
      name: _nameController.toString(),
      email: _emailController.toString(),
      phone: _phoneController.toString(),
    );
    final DataHandling dataHandling = DataHandling(Dio());
    await dataHandling.addUser(newUser);
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();

    try {
      await dataHandling.addUser(newUser);
      usersList.add(newUser);
      print(usersList[10]);
    } catch (e) {
      print(e);
    }
  }

  void _addUser() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Phone: ${_phoneController.text}');
      print('Gender: $_selectedGender');
      print('Age: $_selectedAge');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text(AppLocalizations.of(context)!.user_Added_Successfully)),
      );

      storeUser();
      setState(() {
        _selectedGender = null;
        _selectedAge = null;
      });
      Navigator.pop(context);
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      await userService.createUser(user);
      setState(() {
        usersList.add(user);
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

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addUser,
          style: TextStyle(
              fontSize: widthScreen * 0.06, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(children: [
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
                      return AppLocalizations.of(context)!.please_enter_a_name;
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
                SizedBox(height: heightScreen * 0.02),
                CustomDropdownField(
                  labelText: AppLocalizations.of(context)!.gender,
                  value: _selectedGender,
                  items: _genderOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .please_select_a_gender;
                    }
                    return null;
                  },
                ),
                SizedBox(height: heightScreen * 0.02),
                CustomDropdownField(
                  labelText: AppLocalizations.of(context)!.age,
                  value: _selectedAge,
                  items: _ageOptions,
                  onChanged: (value) {
                    setState(() {
                      _selectedAge = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.please_select_an_age;
                    }
                    return null;
                  },
                ),
                SizedBox(height: heightScreen * 0.03),
                CustomButton(
                  text: AppLocalizations.of(context)!.addUser,
                  icon: Icons.person_add,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  onPressed: _addUser,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
