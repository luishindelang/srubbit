import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Service/s_load_home_tasks.dart';
import 'package:scrubbit/Fronend/Elements/e_done_bottons.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/add_task_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class TaskPopup extends StatefulWidget {
  const TaskPopup({
    super.key,
    required this.task,
    required this.accounts,
    required this.homeTaskService,
  });

  final DsTask task;
  final List<DsAccount> accounts;
  final SLoadHomeTasks homeTaskService;

  @override
  State<TaskPopup> createState() => _TaskPopupState();
}

class _TaskPopupState extends State<TaskPopup> {
  late DsTask task;
  List<DsAccount> selectedAccounts = [];
  bool selectAll = false;

  void onSelectedAccount(List<DsAccount>? newSelectedAccounts) {
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
    showDialog<DsTask>(
      context: context,
      builder: (context) => AddTaskPopup(task: task, accounts: widget.accounts),
    ).then((newTask) {
      if (newTask != null) {
        setState(() {
          widget.homeTaskService.updateTask(task, newTask);
          task = newTask;
        });
      }
    });
  }

  void onDone() {
    if (canDoDone()) {
      Navigator.pop(context, true);
      print("done");
    }
  }

  void onNext() {
    var newTask = task.copyWith(newOffset: 1);
    widget.homeTaskService.updateTask(task, newTask);
    Navigator.pop(context);
  }

  @override
  void initState() {
    task = widget.task;
    super.initState();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ETaskElement(task: task),
              Padding(
                padding: const EdgeInsets.all(paddingBox),
                child: Column(
                  children: [
                    ESelectAccount(
                      accounts: widget.accounts,
                      selectedAccounts: selectedAccounts,
                      onSelectedAccount: onSelectedAccount,
                      onExtraPressed: () {},
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
      ),
    );
  }
}
