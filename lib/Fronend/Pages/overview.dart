import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_repeating_templates.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Elements/e_repeating_task_element_button.dart';
import 'package:scrubbit/Fronend/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account.dart';
import 'package:scrubbit/Fronend/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_account_popup.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_repeating_task_popup.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/test_data.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  final accounts = createAccounts(2);
  List<DsTask> repeatingTasks = [
    DsTask(
      name: "name",
      emoji: "e",
      onEveryDate: false,
      taskDates: [],
      isImportant: false,
      timeFrom: TimeOfDay(hour: 13, minute: 20),
      repeatingTemplate: DsRepeatingTemplates(
        repeatingType: 2,
        repeatingIntervall: 5,
        repeatAfterDone: true,
        startDate: getNowWithoutTime(),
      ),
    ),
  ];
  List<DsAccount> selectedAccounts = [];

  void routePop() {
    Navigator.pop(context);
  }

  void onRepeatingTaskPressed(DsTask task) {
    showDialog<DsTask>(
      context: context,
      builder:
          (context) => EditRepeatingTaskPopup(task: task, accounts: accounts),
    ).then((newTask) {
      if (newTask != null) {
        setState(() {
          repeatingTasks.remove(task);
          repeatingTasks.add(newTask);
        });
      }
      print("after repeating edit");
    });
  }

  void onEditAccouts() {
    showDialog<List<DsAccount>>(
      context: context,
      builder: (context) => EditAccountPopup(),
    ).then((value) {
      print("after account edit");
    });
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
          ETaskBoxTitle(
            flex: 1,
            title: "Repeating Tasks",
            children:
                repeatingTasks
                    .map(
                      (task) => ERepeatingTaskElementButton(
                        task: task,
                        onPressed: () => onRepeatingTaskPressed(task),
                      ),
                    )
                    .toList(),
          ),
          SizedBox(width: 10),
          ETaskBoxTitle(
            flex: 2,
            title: "Score Overview",
            behindTitle: Expanded(
              child: ESelectAccount(
                reverse: true,
                accounts: accounts,
                selectedAccounts: selectedAccounts,
                onSelectedAccount: (newSelectedAccounts) {
                  selectedAccounts = newSelectedAccounts;
                },
                onExtraPressed: () {},
                withShadow: true,
              ),
            ),
            children: [],
          ),
        ],
      ),
    );
  }
}
