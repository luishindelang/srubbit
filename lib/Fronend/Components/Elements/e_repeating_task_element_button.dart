import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_task_element.dart';

class ERepeatingTaskElementButton extends StatelessWidget {
  const ERepeatingTaskElementButton({
    super.key,
    required this.task,
    required this.onPressed,
  });

  final DsTask task;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(onTap: onPressed, child: ETaskElement(task: task)),
    );
  }
}
