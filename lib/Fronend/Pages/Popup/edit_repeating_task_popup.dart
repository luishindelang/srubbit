import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Service/s_create_task.dart';
import 'package:scrubbit/Fronend/Elements/e_emoji_name_input.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_bottom_button.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_repeating.dart';
import 'package:scrubbit/Fronend/Elements/e_select_time_from_until.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class EditRepeatingTaskPopup extends StatefulWidget {
  const EditRepeatingTaskPopup({
    super.key,
    required this.task,
    required this.accounts,
  });

  final DsTask task;
  final List<DsAccount> accounts;

  @override
  State<EditRepeatingTaskPopup> createState() => _EditRepeatingTaskPopupState();
}

class _EditRepeatingTaskPopupState extends State<EditRepeatingTaskPopup> {
  SCreateTask taskService = SCreateTask();

  void onChangeEmoji(String newEmoji) {
    setState(() {
      taskService.emoji = newEmoji;
    });
  }

  void onChangeName(String newName) {
    setState(() {
      taskService.name = newName;
    });
  }

  void onChangeImportant(bool newIsImportant) {
    setState(() {
      taskService.isImportant = newIsImportant;
    });
  }

  @override
  void initState() {
    taskService.loadDataFromTask(widget.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 800,
        decoration: BoxDecoration(
          color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadiusBox),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EEmojiNameInput(
                name: taskService.name,
                onChangeName: onChangeName,
                emojy: taskService.emoji,
                onChangeEmoji: onChangeEmoji,
                isImportant: taskService.isImportant,
                onChangeImportant: onChangeImportant,
              ),
              ESelectTimeFromUntil(
                onTimeSelect: taskService.onTimesSelect,
                timeFrom: taskService.timeFrom,
                timeUntil: taskService.timeUntil,
              ),
              ENewTaskRepeating(taskService: taskService),
              ENewTaskBottomButton(
                accounts: widget.accounts,
                taskService: taskService,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
