import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';
import 'package:scrubbit/Backend/Service/s_create_task.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_emoji_name_input.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_bottom_button.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_repeating.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_time_from_until.dart';
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
                onChangeName: taskService.onChangeName,
                emojy: taskService.emoji,
                onChangeEmoji: taskService.onChangeEmoji,
                isImportant: taskService.isImportant,
                onChangeImportant: taskService.onChangeImportant,
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
                isEdit: true,
                onDelete: () async {
                  var db = await DatabaseService.init();
                  await db.daoTasks.delete(widget.task.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
