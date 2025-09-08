import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/add_edit_task_popup.dart';
import 'package:scrubbit/Fronend/Pages/Popup/task_popup.dart';
import 'package:scrubbit/Fronend/Pages/overview.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<UiHome>();
    home.loadData();
    final accounts = context.read<UiAccount>();
    accounts.loadAccounts();

    void showNewTaskPopup() {
      showDialog(
        context: context,
        builder:
            (context) => ChangeNotifierProvider(
              create: (_) => UiCreateTask(),
              child: AddEditTaskPopup(),
            ),
      );
    }

    void routeOverview() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Overview()),
      );
    }

    void onTaskTap(DsTaskDate taskDate) {
      showDialog(
        context: context,
        builder: (context) => TaskPopup(taskDate: taskDate),
      );
    }

    return EScaffold(
      weekday: weekDaysFull[getNowWithoutTime().weekday - 1],
      date: formatDateDay(getNowWithoutTime(), true, true),
      onAddPressed: showNewTaskPopup,
      onSettingsPressed: routeOverview,
      settingsIcon: Icons.explore_rounded,
      missedTasks: home.missedTasks,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ETaskBoxTitle(
            title: "Heute",
            children:
                home.todayTasks
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
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diese Woche",
            children:
                home.weekTasks
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
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diesen Monat",
            children:
                home.monthTasks
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
        ],
      ),
    );
  }
}
