import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/DB/DataStrukture/ds_task.dart';
import 'package:scrubbit/Backend/Functions/f_assets.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Style/Constants/colors.dart';
import 'package:scrubbit/Fronend/Style/Constants/shadows.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/Style/Constants/text_style.dart';

class ETaskElement extends StatelessWidget {
  const ETaskElement({super.key, required this.task});

  final DsTask task;

  Widget showTime() {
    if (task.timeFrom != null) {
      String text = "";
      if (task.timeUntil != null) {
        text =
            "${formatTime(task.timeFrom!)} - ${formatTime(task.timeUntil!)} Uhr";
      } else {
        text = "${formatTime(task.timeFrom!)} Uhr";
      }
      return Text(
        text,
        style: taskElementDate,
        textHeightBehavior: TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false,
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget showImportant() {
    if (task.isImportant) {
      return Padding(
        padding: const EdgeInsets.only(right: paddingImageright),
        child: FAssets.importantActive,
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingTaskElement),
      decoration: BoxDecoration(
        color: task.isImportant ? importantTaskColor : scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
        boxShadow: [shadowTaskElement],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: paddingEmojiHor),
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
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                    applyHeightToLastDescent: false,
                  ),
                ),
              ],
            ),
          ),
          showImportant(),
        ],
      ),
    );
  }
}
