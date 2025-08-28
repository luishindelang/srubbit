import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/database_service.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
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
    required this.dbService,
    required this.homeTaskService,
  });

  final DsTask task;
  final DatabaseService dbService;
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
      builder:
          (context) =>
              AddTaskPopup(task: task, accounts: widget.dbService.getAccounts),
    ).then((newTask) {
      if (newTask != null) {
        setState(() async {
          widget.homeTaskService.updateTask(task, newTask);
          await widget.dbService.daoTasks.update(newTask);
          task = newTask;
        });
      }
    });
  }

  void onDone() async {
    if (canDoDone()) {
      if (isToday(task.taskDates.last.plannedDate)) {
        DsTask? newRepeatingTask = task.nextRepeatingTask();
        if (newRepeatingTask != null) {
          await widget.dbService.daoTasks.insert(
            newRepeatingTask,
            isNewRepeatingTask: true,
          );
        }
      }
      for (var taskDate in task.taskDates) {
        if (isToday(taskDate.plannedDate)) {
          var newTaskDate = taskDate.copyWith(
            newDoneDate: DateTime.now(),
            newDoneBy: selectedAccounts,
          );
          await widget.dbService.daoTaskDates.update(newTaskDate);
          break;
        }
      }

      Navigator.pop(context, true);
    }
  }

  void onNext() async {
    var newTask = task.copyWith(newOffset: task.offset + 1);
    widget.homeTaskService.updateTask(task, newTask);
    await widget.dbService.daoTasks.update(newTask);
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
                      accounts: widget.dbService.getAccounts,
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
