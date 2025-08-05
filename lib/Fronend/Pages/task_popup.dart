import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Fronend/Elements/e_done_bottons.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class TaskPopup extends StatefulWidget {
  const TaskPopup({super.key, required this.task, required this.accounts});

  final DsTask task;
  final List<DsAccount> accounts;

  @override
  State<TaskPopup> createState() => _TaskPopupState();
}

class _TaskPopupState extends State<TaskPopup> {
  List<String> selectedAccounts = [];
  bool selectAll = false;

  void onSelectedAccount(List<String>? newSelectedAccounts) {
    setState(() {
      if (newSelectedAccounts != null) {
        selectedAccounts = newSelectedAccounts;
        selectAll = false;
      } else {
        selectedAccounts = [];
        selectAll = !selectAll;
      }
    });
  }

  bool canDoDone() {
    return selectedAccounts.isNotEmpty || selectAll;
  }

  void onEdit() {
    print("Edit");
  }

  void onDone() {
    print("done");
  }

  void onNext() {
    widget.task.copyWith(newOffset: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(paddingTaskPopup),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
      ),
      backgroundColor: scaffoldBackgroundColor,
      child: SizedBox(
        width: widthTaskPopup,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ETaskElement(task: widget.task),
            Padding(
              padding: const EdgeInsets.all(paddingBox),
              child: Column(
                children: [
                  ESelectAccount(
                    accounts: widget.accounts,
                    onSelectedAccount: onSelectedAccount,
                    selectAll: selectAll,
                  ),
                  SizedBox(height: 70),
                  EDoneBottons(
                    canBeDone: canDoDone(),
                    onEdit: onEdit,
                    onDone: onDone,
                    onNext: onNext,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
