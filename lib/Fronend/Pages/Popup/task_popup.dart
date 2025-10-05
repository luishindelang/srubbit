import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_done_bottons.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_account.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/add_edit_task_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/eng.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class TaskPopup extends StatefulWidget {
  const TaskPopup({super.key, required this.taskDate});

  final DsTaskDate taskDate;

  @override
  State<TaskPopup> createState() => _TaskPopupState();
}

class _TaskPopupState extends State<TaskPopup> {
  List<DsAccount> selectedAccounts = [];
  bool get selectAll => selectedAccounts.isEmpty;

  bool get canDoDone => selectedAccounts.isNotEmpty || selectAll;

  void onEdit() {
    showDialog(
      context: context,
      builder:
          (context) => ChangeNotifierProvider(
            create: (_) => UiCreateTask(task: widget.taskDate.task),
            child: AddEditTaskPopup(),
          ),
    );
  }

  @override
  void initState() {
    if (widget.taskDate.task.taskOwners != null) {
      selectedAccounts = [...widget.taskDate.task.taskOwners!];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<UiHome>();
    final account = context.watch<UiAccount>();

    void onDone() {
      if (canDoDone) {
        final a =
            selectedAccounts.isNotEmpty ? selectedAccounts : account.accounts;
        home.onTaskDateDone(widget.taskDate, a);
        account.updateScore(a);
        Navigator.pop(context);
      }
    }

    void onNext() {
      home.onTaskMoveToNextDay(widget.taskDate);
      Navigator.pop(context);
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
              ETaskElement(task: widget.taskDate.task),
              Padding(
                padding: const EdgeInsets.all(paddingBox),
                child: Column(
                  children: [
                    ESelectAccount(
                      accounts: account.accounts,
                      selectedAccounts: selectedAccounts,
                      onSelectedAccount:
                          (newSelectedAccounts) => setState(() {
                            selectedAccounts = newSelectedAccounts;
                          }),
                      onSelectAll:
                          () => setState(() {
                            selectedAccounts = [];
                          }),
                      selectAll: selectAll,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${weekDaysFull[widget.taskDate.plannedDate.weekday - 1]}, ${formatDateDay(widget.taskDate.plannedDate, true, true)}",
                            style: taskDateTimeNormal,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    EDoneBottons(
                      canBeDone: canDoDone,
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
