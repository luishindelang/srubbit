import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_icon_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/delete_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class TaskDonePopup extends StatelessWidget {
  const TaskDonePopup({super.key, required this.taskDate});

  final DsTaskDate taskDate;

  @override
  Widget build(BuildContext context) {
    final home = context.read<UiHome>();
    final account = context.read<UiAccount>();
    List<DsAccount> doneBy = [];
    if (taskDate.doneBy != null) {
      doneBy = taskDate.doneBy!;
    }
    return Dialog(
      insetPadding: EdgeInsets.all(paddingTaskPopup),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
      ),
      backgroundColor: scaffoldBackgroundColor,
      child: SizedBox(
        width: widthTaskPopup,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ETaskElement(task: taskDate.task, taskDate: taskDate),
              Padding(
                padding: const EdgeInsets.all(paddingBox),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: sizeIconDonePopup,
                          color: buttonColor,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                doneBy
                                    .map(
                                      (user) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 6,
                                        ),
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: user.color,
                                          borderRadius: BorderRadius.circular(
                                            borderRadiusButtons,
                                          ),
                                          boxShadow: [shadowTaskElement],
                                        ),
                                        child: Text(
                                          user.name,
                                          style: taskDoneNormal,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CIconButton(
                          paddingHor: 10,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => DeletePopup(
                                    onDelete: () {
                                      home.removeDone(taskDate);
                                      account.onDeleteTaskDate();
                                      Navigator.popUntil(
                                        context,
                                        (route) => route.isFirst,
                                      );
                                    },
                                  ),
                            );
                          },
                          icon: Icon(
                            Icons.delete_outline_outlined,
                            color: buttonColor,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
