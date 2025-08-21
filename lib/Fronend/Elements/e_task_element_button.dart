import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/task_popup.dart';
import 'package:scrubbit/test_data.dart';

class ETaskElementButton extends StatelessWidget {
  const ETaskElementButton({
    super.key,
    required this.task,
    required this.accounts,
    this.onPressed,
  });

  final DsTask task;
  final List<DsAccount> accounts;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    void showDialogPopup() {
      if (onPressed == null) {
        showDialog(
          context: context,
          builder:
              (context) => TaskPopup(task: task, accounts: createAccounts(2)),
        );
      } else {
        onPressed!();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(onTap: showDialogPopup, child: ETaskElement(task: task)),
    );
  }
}
