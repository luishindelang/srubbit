import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Service/s_create_task.dart';
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
    required this.accounts,
    this.task,
    this.isEdit = false,
    this.onDelete,
  });

  final List<DsAccount> accounts;
  final DsTask? task;
  final bool isEdit;
  final VoidCallback? onDelete;

  @override
  State<AddTaskPopup> createState() => _AddTaskPopupState();
}

class _AddTaskPopupState extends State<AddTaskPopup> {
  SCreateTask taskService = SCreateTask();

  void onChangeEmoji(String newEmoji) {
    setState(() {
      taskService.onChangeEmoji(newEmoji);
    });
  }

  void onChangeName(String newName) {
    setState(() {
      taskService.onChangeName(newName);
    });
  }

  void onIsRepeating(bool newIsRepeating) {
    setState(() {
      taskService.onIsRepeating(newIsRepeating);
    });
  }

  @override
  void initState() {
    if (widget.task != null) taskService.loadDataFromTask(widget.task!);
    if (widget.accounts.isNotEmpty) taskService.selecedAccounts = [];
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
                emojy: taskService.emoji,
                onChangeEmoji: onChangeEmoji,
                name: taskService.name,
                onChangeName: onChangeName,
                isImportant: taskService.isImportant,
                onChangeImportant: taskService.onChangeImportant,
              ),
              ESelectTimeFromUntil(
                isRepeating: taskService.isRepeating,
                onIsRepeating: onIsRepeating,
                onTimeSelect: taskService.onTimesSelect,
                timeFrom: taskService.timeFrom,
                timeUntil: taskService.timeUntil,
              ),
              Visibility(
                visible: !taskService.isRepeating,
                child: ENewTaskNormal(taskService: taskService),
              ),
              Visibility(
                visible: taskService.isRepeating,
                child: ENewTaskRepeating(taskService: taskService),
              ),
              ENewTaskBottomButton(
                accounts: widget.accounts,
                taskService: taskService,
                isEdit: widget.isEdit,
                onDelete: () {
                  if (widget.onDelete != null) {
                    widget.onDelete!();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
