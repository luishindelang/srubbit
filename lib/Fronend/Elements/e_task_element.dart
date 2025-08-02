import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Elements/e_task_popup.dart';
import 'package:scrubbit/Style/Constants/colors.dart';
import 'package:scrubbit/Style/Constants/shadows.dart';
import 'package:scrubbit/Style/Constants/sizes.dart';
import 'package:scrubbit/Style/Constants/text_style.dart';

class ETaskElement extends StatelessWidget {
  const ETaskElement({
    super.key,
    required this.task,
    this.isTodayImportant = false,
    this.isPopup = false,
  });

  final DsTask task;
  final bool isTodayImportant;
  final bool isPopup;

  Widget showTime() {
    if (task.timeFrom != null && task.timeUntil != null) {
      return Text(
        "${formatTime(task.timeFrom!)} - ${formatTime(task.timeUntil!)} Uhr",
        style: taskElementDate,
      );
    } else if (task.timeFrom != null && task.timeUntil == null) {
      return Text("${formatTime(task.timeFrom!)} Uhr", style: taskElementDate);
    }
    return SizedBox.shrink();
  }

  Widget showImportant() {
    if (task.isImportant) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text("!", style: TextStyle(fontSize: 40)),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          if (!isPopup) {
            showDialog(
              context: context,
              builder: (context) => ETaskPopup(task: task),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(paddingTaskElement),
          decoration: BoxDecoration(
            color:
                task.isImportant && isTodayImportant
                    ? importantTaskColor
                    : scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadiusTaskElement),
            boxShadow: [shadowTaskElement],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(task.emoji, style: taskElementEmoji),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showTime(),
                    Text(
                      task.name,
                      style: taskElementName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              showImportant(),
            ],
          ),
        ),
      ),
    );
  }
}
