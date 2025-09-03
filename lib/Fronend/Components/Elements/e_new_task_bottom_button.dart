import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_icon_button.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_select_account.dart';
import 'package:scrubbit/Fronend/Pages/Popup/delete_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/UI-State/ui_account.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class ENewTaskBottomButton extends StatelessWidget {
  const ENewTaskBottomButton({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    final account = context.watch<UiAccount>();
    final createTask = context.watch<UiCreateTask>();
    final home = context.read<UiHome>();
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
              accounts: account.accounts,
              selectedAccounts: createTask.selecedAccounts,
              onSelectedAccount: createTask.onSelectAccount,
              onExtraPressed: () {},
              onSelectAll: createTask.onSelectAllAccounts,
              selectAll: createTask.selectAll,
            ),
          ),
        ),
        Row(
          children: [
            Visibility(
              visible: isEdit,
              child: CIconButton(
                paddingHor: 10,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeletePopup(onDelete: () {}),
                  );
                },
                icon: Icon(
                  Icons.delete_outline_outlined,
                  color: buttonColor,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  if (createTask.canDoDone) {
                    var newTask = createTask.onDone();
                    if (newTask != null) {
                      home.addTaskDate(newTask);
                    }
                    Navigator.pop(context);
                  }
                },
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
                      createTask.canDoDone
                          ? FAssets.doneActive
                          : FAssets.doneInactive,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
