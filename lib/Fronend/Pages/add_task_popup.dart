import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Elements/e_emoji_name_input.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_bottom_button.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_repeating.dart';
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
  bool isRepeating = false;
  bool get canBeDone => emoji != null && name != null;

  void getNewEmoji(String newEmoji) {
    setState(() {
      emoji = newEmoji;
    });
  }

  void getNewName(String newName) {
    setState(() {
      name = newName;
    });
  }

  void onIsRepeating(bool newIsRepeating) {
    setState(() {
      isRepeating = newIsRepeating;
    });
  }

  void getTimes(TimeOfDay? timeFrom, TimeOfDay? timeUntil) {}

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
                onChangeEmoji: getNewEmoji,
                onChangeName: getNewName,
                onChangeImportant: (i) => isImportant = i,
              ),
              ESelectTimeFromUntil(
                isRepeating: isRepeating,
                onIsRepeating: onIsRepeating,
                onTimeSelect: getTimes,
              ),
              Visibility(visible: !isRepeating, child: ENewTaskNormal()),
              Visibility(visible: isRepeating, child: ENewTaskRepeating()),
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
