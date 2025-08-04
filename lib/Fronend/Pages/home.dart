import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Fronend/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element_button.dart';
import 'package:scrubbit/Fronend/Pages/add_task_popup.dart';
import 'package:scrubbit/test_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final accounts = createAccounts(2);
  void showNewTaskPopup() {
    showDialog(
      context: context,
      builder: (context) => AddTaskPopup(isRepeating: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EScaffold(
      weekday: "Monday",
      date: "23.07.2025",
      onAddPressed: showNewTaskPopup,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ETaskBoxTitle(
            title: "Heute",
            children: [
              ETaskElementButton(
                accounts: accounts,
                task: DsTask(
                  name: "Putzen ist ein ganz langer name der nicht drauf passt",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: true,
                  timeFrom: DateTime(2023, 1, 1, 12, 20),
                  timeUntil: DateTime(2023, 1, 1, 13, 10),
                ),
              ),
              ETaskElementButton(
                accounts: accounts,
                task: DsTask(
                  name: "Putzen ist ein ganz langer name der nicht drauf passt",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: false,
                  timeFrom: DateTime(2023, 1, 1, 8, 40),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diese Woche",
            children: [
              ETaskElementButton(
                accounts: accounts,
                task: DsTask(
                  name: "Putzen ist ein ganz langer name der nicht drauf passt",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: false,
                  timeFrom: DateTime(2023, 1, 1, 12, 20),
                  timeUntil: DateTime(2023, 1, 1, 13, 10),
                ),
              ),
              ETaskElementButton(
                accounts: accounts,
                task: DsTask(
                  name: "Putzen",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: true,
                  timeFrom: DateTime(2023, 1, 1, 8, 40),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diesen Monat",
            children: [
              Text("hallo das ist ein test"),
              Text("hallo das ist ein test"),
              Text("hallo das ist ein test"),
              FAssets.completeActive,
              FAssets.completeInactive,
              FAssets.doneActive,
              FAssets.doneInactive,
              FAssets.importantActive,
              FAssets.importantInactive,
              FAssets.xActive,
              FAssets.xInactive,
            ],
          ),
        ],
      ),
    );
  }
}
