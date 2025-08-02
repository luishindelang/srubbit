import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/database_service.dart';
import 'package:scrubbit/Fronend/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    var ds = await DatabaseService.init();
    ds.accounts = [
      DsAccount(name: "User", color: Colors.blue, icon: Icons.abc),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return EScaffold(
      weekday: "Monday",
      date: "23.07.2025",
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ETaskBoxTitle(
            title: "Heute",
            children: [
              ETaskElement(
                task: DsTask(
                  name: "Putzen ist ein ganz langer name der nicht drauf passt",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: true,
                  timeFrom: DateTime(2023, 1, 1, 12, 20),
                  timeUntil: DateTime(2023, 1, 1, 13, 10),
                ),
                isTodayImportant: true,
              ),
              ETaskElement(
                task: DsTask(
                  name: "Putzen ist ein ganz langer name der nicht drauf passt",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: false,
                  timeFrom: DateTime(2023, 1, 1, 8, 40),
                ),
                isTodayImportant: false,
              ),
            ],
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diese Woche",
            children: [
              ETaskElement(
                task: DsTask(
                  name: "Putzen ist ein ganz langer name der nicht drauf passt",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: false,
                  timeFrom: DateTime(2023, 1, 1, 12, 20),
                  timeUntil: DateTime(2023, 1, 1, 13, 10),
                ),
                isTodayImportant: false,
              ),
              ETaskElement(
                task: DsTask(
                  name: "Putzen ist ein ganz langer name der nicht drauf passt",
                  emoji: "😄",
                  onEveryDate: true,
                  taskDates: [],
                  isImportant: true,
                  timeFrom: DateTime(2023, 1, 1, 8, 40),
                ),
                isTodayImportant: false,
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
            ],
          ),
        ],
      ),
    );
  }
}
