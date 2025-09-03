import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_monthly.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_normal_weekly.dart';
import 'package:scrubbit/Fronend/Components/Elements/e_new_task_repeating_after_complete.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_repeating_intervall.dart';
import 'package:scrubbit/Fronend/Components/Widgets/e_new_task_repeating_select_date.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';
import 'package:scrubbit/Fronend/UI-State/ui_create_task.dart';

class ENewTaskRepeating extends StatefulWidget {
  const ENewTaskRepeating({super.key});

  @override
  State<ENewTaskRepeating> createState() => _ENewTaskRepeatingState();
}

class _ENewTaskRepeatingState extends State<ENewTaskRepeating> {
  late UiCreateTask createTask;

  @override
  void initState() {
    createTask = context.watch<UiCreateTask>();
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
                onIntervallChanged: createTask.onRepeatingIntervall,
                repeatingIntervall: createTask.repeatingIntervall,
                onTypeChanged: createTask.onRepeatingType,
                repeatingType: createTask.repeatingType,
              ),
              SizedBox(width: 30),
              ENewTaskRepeatingAfterComplete(
                value: createTask.repeatAfterDone,
                onChanged: createTask.onAfterComplete,
              ),
            ],
          ),
          SizedBox(height: 20),
          ENewTaskRepeatingSelectDate(
            title: "Begin:",
            selectedDate: createTask.startDateRepeating,
            onDatePressed: createTask.onStartDateRepeating,
          ),
          SizedBox(height: 20),
          ENewTaskRepeatingSelectDate(
            title: "End:",
            selectedDate: createTask.endDateRepeating,
            onDatePressed: createTask.onEndDateRepeating,
            isEnd: true,
            startDate: createTask.startDateRepeating,
            onRepeatingCount: createTask.onRepeatingCount,
          ),
          SizedBox(height: 20),
          Visibility(
            visible: createTask.repeatingType == 1,
            child: ENewTaskNormalWeekly(
              withShowSelect: false,
              weekDays: getNext7Weekdays(),
            ),
          ),
          Visibility(
            visible:
                createTask.repeatingType == 2 || createTask.repeatingType == 3,
            child: ENewTaskNormalMonthly(),
          ),
        ],
      ),
    );
  }
}
