import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_emoji_name_input.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_bottom_button.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_repeating.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_time_from_until.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';

class EditRepeatingTaskPopup extends StatefulWidget {
  const EditRepeatingTaskPopup({super.key});

  @override
  State<EditRepeatingTaskPopup> createState() => _EditRepeatingTaskPopupState();
}

class _EditRepeatingTaskPopupState extends State<EditRepeatingTaskPopup> {
  @override
  Widget build(BuildContext context) {
    final createTask = context.watch<UiCreateTask>();
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
                name: createTask.name,
                onChangeName: createTask.onChangeName,
                emojy: createTask.emoji,
                onChangeEmoji: createTask.onChangeEmoji,
                isImportant: createTask.isImportant,
                onChangeImportant: createTask.onChangeImportant,
              ),
              ESelectTimeFromUntil(
                onTimeSelect: createTask.onTimesSelect,
                timeFrom: createTask.timeFrom,
                timeUntil: createTask.timeUntil,
              ),
              ENewTaskRepeating(),
              ENewTaskBottomButton(isEdit: true),
            ],
          ),
        ),
      ),
    );
  }
}
