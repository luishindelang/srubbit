import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Fronend/Elements/e_task_element.dart';
import 'package:scrubbit/Style/Constants/colors.dart';
import 'package:scrubbit/Style/Constants/sizes.dart';

class ETaskPopup extends StatelessWidget {
  const ETaskPopup({super.key, required this.task});

  final DsTask task;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth - marginTaskPopup - marginTaskPopup;
    return Dialog(
      insetPadding: EdgeInsets.all(paddingTaskPopup),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
      ),
      backgroundColor: scaffoldBackgroundColor,
      child: SizedBox(
        width: maxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [ETaskElement(task: task, isPopup: true)],
        ),
      ),
    );
  }
}
