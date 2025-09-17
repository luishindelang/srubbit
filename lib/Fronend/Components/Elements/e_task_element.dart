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

  BoxDecoration bandBackground(List<Color> colors) {
    final n = colors.length;
    final cum = <double>[];

    for (var i = 0; i <= n; i++) {
      cum.add(i / n);
    }

    final gColors = <Color>[];
    final gStops = <double>[];
    for (var i = 0; i < n; i++) {
      gColors
        ..add(colors[i])
        ..add(colors[i]);
      gStops
        ..add(cum[i])
        ..add(cum[i + 1]);
    }

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gColors,
        stops: gStops,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadiusTaskElement),
        bottomLeft: Radius.circular(borderRadiusTaskElement),
      ),
    );
  }

  Widget showOwner() {
    if (task.taskOwners == null ? true : task.taskOwners!.isEmpty) {
      return SizedBox(width: 14);
    }
    return Container(
      margin: EdgeInsets.only(right: 4),
      width: 10,
      height: 63,
      decoration: bandBackground(
        task.taskOwners!.map((account) => account.color).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: task.isImportant ? importantTaskColor : scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadiusTaskElement),
        boxShadow: [shadowTaskElement],
      ),
      child: Row(
        children: [
          showOwner(),
          Text(task.emoji, style: taskElementEmoji),
          SizedBox(width: 2),
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
