import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_box_title.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_account.dart';
import 'package:scrubbit/Fronend/Pages/Popup/edit_account_popup.dart';
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
      title: "Score Overview",
      behindTitle: Expanded(
        child: ESelectAccount(
          reverse: true,
          accounts: account.accounts,
          selectedAccounts: selectedAccounts,
          onSelectedAccount: (newSelectedAccounts) {
            selectedAccounts = newSelectedAccounts;
          },
          onExtraPressed: onEditAccouts,
          onSelectAll: onSelectAll,
          selectAll: selectedAccounts.isEmpty,
          withShadow: true,
        ),
      ),
      children: [],
    );
  }
}
