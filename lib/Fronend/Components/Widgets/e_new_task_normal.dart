import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_monthly.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_normal_preset_buttons.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_weekly.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskNormal extends StatefulWidget {
  const ENewTaskNormal({super.key, required this.type});

  final int type;

  @override
  State<ENewTaskNormal> createState() => _ENewTaskNormalState();
}

class _ENewTaskNormalState extends State<ENewTaskNormal> {
  late int type;

  void onChangeType(int newType) {
    setState(() {
      type = newType;
    });
  }

  Widget showTypeElements() {
    switch (type) {
      case 2:
        return ENewTaskNormalWeekly(weekDays: getNext7Weekdays());
      case 3:
        return ENewTaskNormalMonthly(withShowSelect: true);
      case 4:
        return ENewTaskNormalMonthly();
      default:
        return const SizedBox(height: 20);
    }
  }

  @override
  void initState() {
    type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: newTaskBodySedePadding - 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ENewTaskNormalPresetButtons(type: type, onChange: onChangeType),
          SizedBox(height: 20),
          showTypeElements(),
        ],
      ),
    );
  }
}
