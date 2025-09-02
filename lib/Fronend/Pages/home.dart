import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Backend/Service/s_load_home_tasks.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/Pages/Popup/add_task_popup.dart';
import 'package:scrubbit/Fronend/Pages/Popup/task_popup.dart';
import 'package:scrubbit/Fronend/Pages/overview.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DatabaseService dbService;
  final SLoadHomeTasks homeTaskService = SLoadHomeTasks();
  List<DsAccount> accounts = [];
  bool isLoaded = false;

  void showNewTaskPopup() {
    showDialog<DsTask>(
      context: context,
      builder: (context) => AddTaskPopup(accounts: accounts),
    ).then((newTask) async {
      if (newTask != null) {
        await dbService.daoTasks.insert(newTask);
        setState(() {
          homeTaskService.addNewTask(newTask);
        });
      }
    });
  }

  void routeOverview() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Overview(dbService: dbService)),
    ).then((value) {
      setState(() {});
    });
  }

  void onTaskTap(DsTask task) {
    showDialog<bool>(
      context: context,
      builder:
          (context) => TaskPopup(
            task: task,
            dbService: dbService,
            homeTaskService: homeTaskService,
          ),
    ).then((value) {
      setState(() {});
    });
  }

  void loadData() async {
    await SData.instance.loadData();

    setState(() {
      isLoaded = homeTaskService.isLoaded;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
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
                homeTaskService.todayTasks
                    .map(
                      (task) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () => onTaskTap(task),
                          child: ETaskElement(task: task),
                        ),
                      ),
                    )
                    .toList(),
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diese Woche",
            children:
                homeTaskService.weekTasks
                    .map(
                      (task) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () => onTaskTap(task),
                          child: ETaskElement(task: task),
                        ),
                      ),
                    )
                    .toList(),
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            title: "Diesen Monat",
            children:
                homeTaskService.monthTasks
                    .map(
                      (task) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () => onTaskTap(task),
                          child: ETaskElement(task: task),
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
