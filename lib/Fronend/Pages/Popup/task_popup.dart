import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_done_bottons.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_account.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/add_edit_task_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
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
  late UiHome home;
  late UiAccount account;
  late DsTaskDate taskDate;
  List<DsAccount> selectedAccounts = [];
  bool get selectAll => selectedAccounts.isEmpty;

  bool get canDoDone => selectedAccounts.isNotEmpty || selectAll;

  void onEdit() {
    showDialog(
      context: context,
      builder:
          (context) => ChangeNotifierProvider(
            create: (_) => UiCreateTask(),
            child: AddEditTaskPopup(),
          ),
    );
  }

  void onDone() {
    if (canDoDone) {
      home.onTaskDateDone(taskDate);
      Navigator.pop(context);
    }
  }

  void onNext() {
    home.onTasMoveToNextDay(taskDate.task);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    taskDate = widget.taskDate;
    home = context.watch<UiHome>();
    account = context.watch<UiAccount>();
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
              ETaskElement(task: taskDate.task),
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
                      onExtraPressed: () {},
                      onSelectAll:
                          () => setState(() {
                            selectedAccounts = [];
                          }),
                      selectAll: selectAll,
                    ),
                    SizedBox(height: 70),
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
