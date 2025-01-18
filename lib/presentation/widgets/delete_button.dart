import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:user_profile/presentation/widgets/custom_confirmation_dialog.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({super.key});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return IconButton(
      icon: Icon(Icons.delete, color: Colors.red, size: widthScreen * 0.064),
      onPressed: () => _showDeleteConfirmationDialog(context),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomConfirmationDialog(
            title: AppLocalizations.of(context)!.deleteUser,
            content:
                AppLocalizations.of(context)!.areYouSureYouWantToDeleteUser,
            action1: AppLocalizations.of(context)!.delete,
            action2: AppLocalizations.of(context)!.cancel,
            onPressed: () {
              //actions el delete
              //   _deleteUser(user['id']);
              Navigator.pop(context);
            },
            pressed: () {
              Navigator.pop(context, false);
            },
          );
        });
  }

  void _deleteUser(int userId) {
    print('User $userId deleted');
  }
}