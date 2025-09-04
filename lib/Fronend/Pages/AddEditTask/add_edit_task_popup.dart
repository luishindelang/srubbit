import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/Elements/emoji_name_input.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_bottom_button.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/Elements/select_normal_type.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/Elements/select_repeating_type.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/Elements/select_time_from_until.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';

class AddEditTaskPopup extends StatelessWidget {
  const AddEditTaskPopup({super.key});

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
              EmojiNameInput(
                emojy: createTask.emoji,
                onChangeEmoji: createTask.onChangeEmoji,
                name: createTask.name,
                onChangeName: createTask.onChangeName,
                isImportant: createTask.isImportant,
                onChangeImportant: createTask.onChangeImportant,
              ),
              SelectTimeFromUntil(
                isRepeating: createTask.isRepeating,
                onIsRepeating: createTask.onIsRepeating,
                onTimeSelect: createTask.onTimesSelect,
                timeFrom: createTask.timeFrom,
                timeUntil: createTask.timeUntil,
              ),
              Visibility(
                visible: !createTask.isRepeating,
                child: SelectNormalType(type: createTask.type),
              ),
              Visibility(
                visible: createTask.isRepeating,
                child: SelectRepeatingType(),
              ),
              ENewTaskBottomButton(isEdit: createTask.isEdit),
            ],
          ),
        ),
      ),
    );
  }
}
