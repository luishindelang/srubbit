import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Backend/Service/s_create_task.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_monthly.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_normal_preset_buttons.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_weekly.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskNormal extends StatefulWidget {
  const ENewTaskNormal({super.key, required this.taskService});

  final SCreateTask taskService;

  @override
  State<ENewTaskNormal> createState() => _ENewTaskNormalState();
}

class _ENewTaskNormalState extends State<ENewTaskNormal> {
  late int type;

  void onChangeType(int newType) {
    setState(() {
      type = newType;
      widget.taskService.onChangeType(type);
    });
  }

  Widget showTypeElements() {
    switch (type) {
      case 2:
        return ENewTaskNormalWeekly(
          taskService: widget.taskService,
          weekDays: getNext7Weekdays(),
        );
      case 3:
        return ENewTaskNormalMonthly(
          taskService: widget.taskService,
          withShowSelect: true,
        );
      case 4:
        return ENewTaskNormalMonthly(taskService: widget.taskService);
      default:
        return const SizedBox(height: 20);
    }
  }

  @override
  void initState() {
    type = widget.taskService.type;
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
