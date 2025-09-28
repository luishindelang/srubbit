import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_icon_button.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_score_overview_diagramm.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_account.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_task_done_history.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_account_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';
import 'package:scrubbit/Fronend/Style/Language/eng.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';

class EScoreOverview extends StatefulWidget {
  const EScoreOverview({super.key});

  @override
  State<EScoreOverview> createState() => _EScoreOverviewState();
}

class _EScoreOverviewState extends State<EScoreOverview> {
  List<DsAccount> selectedAccounts = [];

  void onSelectAll() {
    setState(() {
      selectedAccounts = [];
    });
  }

  void onSelectAccount(List<DsAccount> newAccounts) {
    setState(() {
      selectedAccounts = newAccounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final account = context.watch<UiAccount>();

    void onEditAccouts() {
      showDialog(
        context: context,
        builder: (context) => EditAccountPopup(accounts: account.accounts),
      );
    }

    return ETaskBoxTitle(
      flex: 2,
      title: textScoreOverview,
      withScroll: false,
      behindTitle: Expanded(
        child: ESelectAccount(
          reverse: true,
          accounts: account.accounts,
          selectedAccounts: selectedAccounts,
          onSelectedAccount: onSelectAccount,
          onExtraPressed: onEditAccouts,
          onSelectAll: onSelectAll,
          selectAll: selectedAccounts.isEmpty,
          withShadow: true,
          neverUnselect: true,
        ),
      ),
      children: [
        EScoreOverviewDiagramm(
          accounts:
              selectedAccounts.isEmpty ? account.accounts : selectedAccounts,
        ),
        SizedBox(height: 20),
        Row(
          spacing: 260,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.history_rounded, color: buttonColor, size: 32),
                  Text(textTaskHistory, style: taskHistory),
                ],
              ),
            ),
            CIconButton(
              onPressed: () {},
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                child: const Icon(
                  Icons.sort_rounded,
                  size: 32,
                  color: buttonColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ETaskDoneHistory(accounts: selectedAccounts),
      ],
    );
  }
}
