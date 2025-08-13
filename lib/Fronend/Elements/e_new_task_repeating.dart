import 'package:flutter/material.dart';
import 'package:scrubbit/Backend/Functions/f_time.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_monthly.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_weekly.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_repeating_after_complete.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_repeating_intervall.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_repeating_select_date.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskRepeating extends StatefulWidget {
  const ENewTaskRepeating({super.key});

  @override
  State<ENewTaskRepeating> createState() => _ENewTaskRepeatingState();
}

class _ENewTaskRepeatingState extends State<ENewTaskRepeating> {
  int repeatingType = 0;
  int repeatingIntervall = 1;
  bool afterComplete = false;
  DateTime startDate = getNowWithoutTime();
  DateTime? endDate;

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
                onIntervallChanged: (newRepeatingIntervall) {
                  repeatingIntervall = newRepeatingIntervall;
                },
                repeatingIntervall: repeatingIntervall,
                onTypeChanged: (newRepeatingType) {
                  setState(() {
                    repeatingType = newRepeatingType;
                  });
                  print(newRepeatingType);
                },
                repeatingType: repeatingType,
              ),
              SizedBox(width: 30),
              ENewTaskRepeatingAfterComplete(
                value: afterComplete,
                onChanged:
                    (newValue) => setState(() {
                      afterComplete = newValue;
                    }),
              ),
            ],
          ),
          SizedBox(height: 20),
          ENewTaskRepeatingSelectDate(
            title: "Begin:",
            selectedDate: startDate,
            onDatePressed:
                (newDate) => setState(() {
                  if (newDate == null) {
                    startDate = getNowWithoutTime();
                  } else {
                    startDate = newDate;
                  }
                  print(startDate);
                }),
          ),
          SizedBox(height: 20),
          ENewTaskRepeatingSelectDate(
            title: "End:",
            selectedDate: endDate,
            onDatePressed: (newDate) {
              endDate = newDate;
              print(endDate);
            },
            isEnd: true,
            startDate: startDate,
          ),
          SizedBox(height: 20),
          Visibility(
            visible: repeatingType == 1,
            child: ENewTaskNormalWeekly(
              onChangeSelected: (newDates) {},
              onChangeOrAnd: (newIsOr) {},
              withShowSelect: false,
            ),
          ),
          Visibility(
            visible: repeatingType == 2 || repeatingType == 3,
            child: ENewTaskNormalMonthly(
              onChangeSelected: (newDates) {},
              onChangeOrAnd: (newIsOr) {},
            ),
          ),
        ],
      ),
    );
  }
}
