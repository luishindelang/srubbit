import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/database_service.dart';
import 'package:scrubbit/Backend/Service/s_load_home_tasks.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/task_popup.dart';

class ETaskElementButton extends StatelessWidget {
  const ETaskElementButton({
    super.key,
    required this.task,
    required this.dbService,
    required this.homeTaskService,
    required this.then,
  });

  final DsTask task;
  final DatabaseService dbService;
  final SLoadHomeTasks homeTaskService;
  final void Function(bool?) then;

  @override
  Widget build(BuildContext context) {
    void showDialogPopup() {
      showDialog<bool>(
        context: context,
        builder:
            (context) => TaskPopup(
              task: task,
              dbService: dbService,
              homeTaskService: homeTaskService,
            ),
      ).then(then);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(onTap: showDialogPopup, child: ETaskElement(task: task)),
    );
  }
}
