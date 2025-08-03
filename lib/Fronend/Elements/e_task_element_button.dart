import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/task_popup.dart';
import 'package:scrubbit/test_data.dart';

class ETaskElementButton extends StatelessWidget {
  const ETaskElementButton({
    super.key,
    required this.task,
    required this.accounts,
  });

  final DsTask task;
  final List<DsAccount> accounts;

  @override
  Widget build(BuildContext context) {
    void showDialogPopup() {
      showDialog(
        context: context,
        builder:
            (context) => TaskPopup(task: task, accounts: createAccounts(2)),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(onTap: showDialogPopup, child: ETaskElement(task: task)),
    );
  }
}
