import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Service/database_service.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_repeating_task_element_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_scaffold.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_account.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_account_popup.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_repeating_task_popup.dart';
import 'package:scrubbit/Fronend/Style/Language/de.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class Overview extends StatefulWidget {
  const Overview({super.key, required this.dbService});

  final DatabaseService dbService;

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  late UiHome home;
  late UiAccount account;
  List<DsAccount> selectedAccounts = [];

  void routePop() {
    Navigator.pop(context);
  }

  void onSelectAll() {
    setState(() {
      selectedAccounts = [];
    });
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

  void onEditAccouts() {
    showDialog<List<DsAccount>>(
      context: context,
      builder: (context) => EditAccountPopup(),
    ).then((value) {
      print("after account edit");
    });
  }

  @override
  void initState() {
    home = context.watch<UiHome>();
    account = context.watch<UiAccount>();
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
          ETaskBoxTitle(
            flex: 2,
            title: "Score Overview",
            behindTitle: Expanded(
              child: ESelectAccount(
                reverse: true,
                accounts: account.accounts,
                selectedAccounts: selectedAccounts,
                onSelectedAccount: (newSelectedAccounts) {
                  selectedAccounts = newSelectedAccounts;
                },
                onExtraPressed: () {},
                onSelectAll: onSelectAll,
                selectAll: selectedAccounts.isEmpty,
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
