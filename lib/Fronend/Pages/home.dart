import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Backend/Service/s_load_home_tasks.dart';
import 'package:scrubbit/Fronend/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element_button.dart';
import 'package:scrubbit/Fronend/Pages/Popup/add_task_popup.dart';
import 'package:scrubbit/Fronend/Pages/overview.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/test_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final SLoadHomeTasks homeTaskService = SLoadHomeTasks();
  final accounts = createAccounts(2);
  bool isLoaded = false;

  void showNewTaskPopup() {
    showDialog<DsTask>(
      context: context,
      builder: (context) => AddTaskPopup(accounts: accounts),
    ).then((newTask) {
      if (newTask != null) {
        setState(() {
          homeTaskService.addNewTask(newTask);
        });
      }
    });
  }

  void routeOverview() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Overview()),
    );
  }

  void afterTaskIneraktion(bool? isDone) {
    setState(() {
      if (isDone != null && isDone) {
        //play animation
      }
    });
  }

  void loadData() async {
    await homeTaskService.loadData();
    setState(() {
      isLoaded = homeTaskService.isLoaded;
    });
  }

  @override
  void initState() {
    homeTaskService.loadData();
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
                      (task) => ETaskElementButton(
                        task: task,
                        accounts: accounts,
                        homeTaskService: homeTaskService,
                        then: afterTaskIneraktion,
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
                      (task) => ETaskElementButton(
                        task: task,
                        accounts: accounts,
                        homeTaskService: homeTaskService,
                        then: afterTaskIneraktion,
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
                      (task) => ETaskElementButton(
                        task: task,
                        accounts: accounts,
                        homeTaskService: homeTaskService,
                        then: afterTaskIneraktion,
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
