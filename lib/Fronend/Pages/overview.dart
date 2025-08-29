import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/DB/database_service.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Elements/e_repeating_task_element_button.dart';
import 'package:scrubbit/Fronend/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account.dart';
import 'package:scrubbit/Fronend/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_account_popup.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_repeating_task_popup.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';

class Overview extends StatefulWidget {
  const Overview({super.key, required this.dbService});

  final DatabaseService dbService;

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  List<DsTask> repeatingTasks = [];
  List<DsAccount> selectedAccounts = [];
  bool selectAll = false;

  void routePop() {
    Navigator.pop(context);
  }

  bool onSelectAll(bool newSelectAll) {
    setState(() {
      selectAll = newSelectAll;
    });
    return selectAll;
  }

  void onRepeatingTaskPressed(DsTask task) {
    showDialog<DsTask>(
      context: context,
      builder:
          (context) => EditRepeatingTaskPopup(
            task: task,
            accounts: widget.dbService.getAccounts,
          ),
    ).then((newTask) async {
      if (newTask != null) {
        setState(() {
          repeatingTasks.remove(task);
          repeatingTasks.add(newTask);
        });
      }
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

  void loadData() async {
    var data = await widget.dbService.daoTasks.getAllRepeating();

    setState(() {
      repeatingTasks = data;
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
                accounts: widget.dbService.getAccounts,
                selectedAccounts: selectedAccounts,
                onSelectedAccount: (newSelectedAccounts) {
                  selectedAccounts = newSelectedAccounts;
                },
                onExtraPressed: () {},
                onSelectAll: onSelectAll,
                selectAll: selectAll,
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
