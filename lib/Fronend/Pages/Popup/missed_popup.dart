import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/task_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class MissedPopup extends StatelessWidget {
  const MissedPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<UiHome>();

    void onTaskTap(DsTaskDate taskDate) {
      showDialog(
        context: context,
        builder: (context) => TaskPopup(taskDate: taskDate),
      );
    }

    return Dialog(
      insetPadding: EdgeInsets.all(40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
      ),
      backgroundColor: taskListBackgroundColor,
      child: SizedBox(
        width: 600,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadiusTaskElement - 1),
                ),
                boxShadow: [shadowScaffoldAppbar],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(textMissedTasks, style: scaffoldAppBarTitleMissed),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children:
                        home.missedTasks
                            .map(
                              (taskDate) => Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: InkWell(
                                  onTap: () => onTaskTap(taskDate),
                                  child: ETaskElement(task: taskDate.task),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
