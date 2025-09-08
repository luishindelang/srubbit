import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_account.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';
import 'package:scrubbit/Fronend/UI-State/ui_home.dart';

class ETaskDoneHistory extends StatelessWidget {
  const ETaskDoneHistory({super.key, required this.accounts});

  final List<DsAccount> accounts;

  @override
  Widget build(BuildContext context) {
    final home = context.read<UiHome>();
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              home
                  .doneTask(accounts)
                  .map(
                    (taskDate) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(child: ETaskElement(task: taskDate.task)),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
