import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task_date.dart';
import 'package:scrubbit/Fronend/Components/Controlls/c_button.dart';
import 'package:scrubbit/Fronend/Pages/Popup/missed_popup.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class EMissedTaskButton extends StatelessWidget {
  const EMissedTaskButton({super.key, required this.missedTasks});

  final List<DsTaskDate> missedTasks;

  @override
  Widget build(BuildContext context) {
    return CButton(
      backgroundColor: importantTaskColor,
      radius: 5,
      paddingVert: 3,
      paddingHor: 4,
      onPressed: () {
        showDialog(context: context, builder: (context) => MissedPopup());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 4),
          Text(
            "${missedTasks.length}",
            style: scaffoldAppBarTitleMissed,
            strutStyle: const StrutStyle(
              forceStrutHeight: true,
              height: 2.0,
              leadingDistribution: TextLeadingDistribution.proportional,
            ),
          ),
          Icon(Icons.notifications_none_rounded, color: buttonColor, size: 35),
        ],
      ),
    );
  }
}
