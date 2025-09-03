import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/add_task_popup.dart';
import 'package:scrubbit/Fronend/Pages/Popup/task_popup.dart';
import 'package:scrubbit/Fronend/Pages/overview.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DatabaseService dbService;
  List<DsAccount> accounts = [];
  bool isLoaded = false;

  void showNewTaskPopup() {
    showDialog(
      context: context,
      builder:
          (context) => ChangeNotifierProvider(
            create: (_) => UiCreateTask(),
            child: AddTaskPopup(),
          ),
    );
  }

  void routeOverview() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Overview(dbService: dbService)),
    );
  }

  void onTaskTap(DsTaskDate taskDate) {
    showDialog(
      context: context,
      builder: (context) => TaskPopup(taskDate: taskDate),
    );
  }

  @override
  void initState() {
    dbService = context.read<DatabaseService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<UiHome>();
    return EScaffold(
      weekday: weekDaysFull[getNowWithoutTime().weekday - 1],
      date: formatDateDay(getNowWithoutTime(), true, true),
      onAddPressed: showNewTaskPopup,
      onSettingsPressed: routeOverview,
      settingsIcon: Icons.explore_rounded,
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
