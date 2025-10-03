import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_repeating_task_element_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_score_overview.dart';
import 'package:scrubbit/Fronend/Pages/AddEditTask/edit_repeating_task_popup.dart';
import 'package:scrubbit/Fronend/Pages/home.dart';
import 'package:scrubbit/Fronend/Style/Language/eng.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  void routePop() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home()),
      (route) => false,
    );
  }

  void onRepeatingTaskPressed(DsTask task) {
    showDialog<DsTask>(
      context: context,
      builder:
          (context) => ChangeNotifierProvider(
            create: (_) => UiCreateTask(task: task),
            child: EditRepeatingTaskPopup(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<UiHome>();
    return EScaffold(
      weekday: weekDaysFull[getNowWithoutTime().weekday - 1],
      date: formatDateDay(getNowWithoutTime(), true, true),
      onSettingsPressed: routePop,
      settingsIcon: Icons.home_rounded,
      body: Row(
        children: [
          ETaskBoxTitle(
            flex: 1,
            title: "Repeating Tasks",
            children:
                home.repeatingTasks
                    .map(
                      (task) => ERepeatingTaskElementButton(
                        task: task,
                        onPressed: () => onRepeatingTaskPressed(task),
                      ),
                    )
                    .toList(),
          ),
          SizedBox(width: 10),
          EScoreOverview(),
        ],
      ),
    );
  }
}
