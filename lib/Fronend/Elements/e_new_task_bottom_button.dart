import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Backend/Service/s_create_task.dart';
import 'package:scrubbit/Fronend/Elements/e_select_account.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskBottomButton extends StatelessWidget {
  const ENewTaskBottomButton({
    super.key,
    required this.accounts,
    required this.taskService,
  });

  final List<DsAccount> accounts;
  final SCreateTask taskService;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              bottom: 70,
            ),
            child: ESelectAccount(
              accounts: accounts,
              selectedAccounts: taskService.selecedAccounts,
              onSelectedAccount: taskService.onSelectAccount,
              onExtraPressed: () {},
              selectAll: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => taskService.onDone(context),
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: sizeDoneButtonNewTask,
              height: sizeDoneButtonNewTask,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [shadowTaskElement],
              ),
              child:
                  taskService.canBeDone
                      ? FAssets.doneActive
                      : FAssets.doneInactive,
            ),
          ),
        ),
      ],
    );
  }
}
