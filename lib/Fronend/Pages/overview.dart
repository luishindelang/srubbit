import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element_button.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/test_data.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final accounts = createAccounts(2);
  List<DsTask> repeatingTasks = [];

  void routePop() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return EScaffold(
      weekday: weekDaysFull[getNowWithoutTime().weekday - 1],
      date: formatDateDay(getNowWithoutTime(), true, true),
      onSettingsPressed: routePop,
      settingsIcon: Icons.home_rounded,
      body: Row(
        children: [
          SizedBox(
            width: 460,
            child: ETaskBoxTitle(
              title: "Repeating Tasks",
              children:
                  repeatingTasks
                      .map(
                        (task) =>
                            ETaskElementButton(task: task, accounts: accounts),
                      )
                      .toList(),
            ),
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(title: "Score Overview", children: []),
        ],
      ),
    );
  }
}
