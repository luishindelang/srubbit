import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Elements/e_emoji_name_input.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_bottom_button.dart';
import 'package:scrubbit/Fronend/Elements/e_select_time_from_until.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class AddTaskPopup extends StatefulWidget {
  const AddTaskPopup({
    super.key,
    required this.isRepeating,
    required this.accounts,
  });

  final bool isRepeating;
  final List<DsAccount> accounts;

  @override
  State<AddTaskPopup> createState() => _AddTaskPopupState();
}

class _AddTaskPopupState extends State<AddTaskPopup> {
  String? emoji;
  String? name;
  bool isImportant = false;
  bool get canBeDone => emoji != null && name != null;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadiusBox),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EEmojiNameInput(
                isImportant: isImportant,
                onChangeEmoji:
                    (newEmoji) => setState(() {
                      emoji = newEmoji;
                    }),
                onChangeName:
                    (newName) => setState(() {
                      name = newName;
                    }),
                onChangeImportant:
                    (newIsImportant) => isImportant = newIsImportant,
              ),
              ESelectTimeFromUntil(onIsRepeating: (bool) {}),
              ENewTaskBottomButton(
                accounts: widget.accounts,
                canBeDone: canBeDone,
                onSelectedAccount: (newAccounts) {},
                onDone: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
