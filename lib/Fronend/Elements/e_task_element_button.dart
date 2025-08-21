import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Service/s_load_home_tasks.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/task_popup.dart';

class ETaskElementButton extends StatelessWidget {
  const ETaskElementButton({
    super.key,
    required this.task,
    required this.accounts,
    required this.homeTaskService,
    required this.then,
  });

  final DsTask task;
  final List<DsAccount> accounts;
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
              accounts: accounts,
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
