import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element_button.dart';
import 'package:scrubbit/Fronend/Pages/add_task_popup.dart';
import 'package:scrubbit/Fronend/Pages/overview.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/test_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final accounts = createAccounts(2);

  List<DsTask> todayTasks = [
    DsTask(
      name: "Putzen ist ein ganz langer name der nicht drauf passt",
      emoji: "😄",
      onEveryDate: true,
      taskDates: [],
      isImportant: true,
      timeFrom: TimeOfDay(hour: 13, minute: 10),
      timeUntil: TimeOfDay(hour: 14, minute: 50),
    ),
    DsTask(
      name: "Putzen ist ein ganz langer name der nicht drauf passt",
      emoji: "😄",
      onEveryDate: true,
      taskDates: [],
      isImportant: false,
      timeFrom: TimeOfDay(hour: 13, minute: 10),
    ),
  ];
  List<DsTask> weekTasks = [];
  List<DsTask> monthTasks = [];

  void showNewTaskPopup() {
    showDialog(
      context: context,
      builder:
          (context) => AddTaskPopup(isRepeating: false, accounts: accounts),
    ).then((value) {
      print("test");
    });
  }

  void routeOverview() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Overview()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                todayTasks
                    .map(
                      (task) =>
                          ETaskElementButton(task: task, accounts: accounts),
                    )
                    .toList(),
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diese Woche",
            children:
                weekTasks
                    .map(
                      (task) =>
                          ETaskElementButton(task: task, accounts: accounts),
                    )
                    .toList(),
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diesen Monat",
            children:
                monthTasks
                    .map(
                      (task) =>
                          ETaskElementButton(task: task, accounts: accounts),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
