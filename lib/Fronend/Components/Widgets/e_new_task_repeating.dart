import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Backend/Service/s_create_task.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_monthly.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_weekly.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_repeating_after_complete.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_repeating_intervall.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_repeating_select_date.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskRepeating extends StatefulWidget {
  const ENewTaskRepeating({super.key, required this.taskService});

  final SCreateTask taskService;

  @override
  State<ENewTaskRepeating> createState() => _ENewTaskRepeatingState();
}

class _ENewTaskRepeatingState extends State<ENewTaskRepeating> {
  late int repeatingType;
  late int repeatingIntervall;

  @override
  void initState() {
    repeatingType = widget.taskService.repeatingType;
    repeatingIntervall = widget.taskService.repeatingIntervall;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: newTaskBodySedePadding,
        vertical: 5.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ENewTaskRepeatingIntervall(
                onIntervallChanged: widget.taskService.onRepeatingIntervall,
                repeatingIntervall: repeatingIntervall,
                onTypeChanged: (newType) {
                  setState(() {
                    repeatingType = newType;
                    widget.taskService.onRepeatingType(newType);
                  });
                },
                repeatingType: repeatingType,
              ),
              SizedBox(width: 30),
              ENewTaskRepeatingAfterComplete(
                value: widget.taskService.afterComplete,
                onChanged: (newAfterComplete) {
                  setState(() {
                    widget.taskService.onAfterComplete(newAfterComplete);
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          ENewTaskRepeatingSelectDate(
            title: "Begin:",
            selectedDate: widget.taskService.startDateRepeating,
            onDatePressed:
                (newDate) => setState(() {
                  widget.taskService.onStartDateRepeating(
                    newDate ?? getNowWithoutTime(),
                  );
                }),
          ),
          SizedBox(height: 20),
          ENewTaskRepeatingSelectDate(
            title: "End:",
            selectedDate: widget.taskService.endDateRepeating,
            onDatePressed:
                (newDate) => setState(() {
                  widget.taskService.onEndDateRepeating(newDate);
                }),
            isEnd: true,
            startDate: widget.taskService.startDateRepeating,
            onRepeatingCount: widget.taskService.onRepeatingCount,
          ),
          SizedBox(height: 20),
          Visibility(
            visible: repeatingType == 1,
            child: ENewTaskNormalWeekly(
              taskService: widget.taskService,
              withShowSelect: false,
              weekDays: getNext7Weekdays(),
            ),
          ),
          Visibility(
            visible: repeatingType == 2 || repeatingType == 3,
            child: ENewTaskNormalMonthly(taskService: widget.taskService),
          ),
        ],
      ),
    );
  }
}
