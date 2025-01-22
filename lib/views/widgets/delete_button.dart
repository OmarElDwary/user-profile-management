import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/custom_confirmation_dialog.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({super.key, required this.onpressesd});

  final VoidCallback onpressesd;

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () => _showDeleteConfirmationDialog(context),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CustomConfirmationDialog(
          title: AppLocalizations.of(context)!.deleteUser,
          content: AppLocalizations.of(context)!.areYouSureYouWantToDeleteUser,
          action1: AppLocalizations.of(context)!.delete,
          action2: AppLocalizations.of(context)!.cancel,
          onPressed: () {
            widget.onpressesd();
            Navigator.pop(context);
          },
          pressed: () {
            Navigator.pop(context, false);
          },
        );
      },
    );
  }
}
