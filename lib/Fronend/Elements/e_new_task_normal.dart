import 'package:flutter/material.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_monthly.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_preset_buttons.dart';
import 'package:scrubbit/Fronend/Elements/e_new_task_normal_weekly.dart';
import 'package:scrubbit/Fronend/Style/Constants/sizes.dart';

class ENewTaskNormal extends StatefulWidget {
  const ENewTaskNormal({super.key});

  @override
  State<ENewTaskNormal> createState() => _ENewTaskNormalState();
}

class _ENewTaskNormalState extends State<ENewTaskNormal> {
  int type = 0;

  void onChangeType(int newType) {
    setState(() {
      type = newType;
    });
  }

  Widget showTypeElements() {
    switch (type) {
      case 2:
        return ENewTaskNormalWeekly(
          onChangeOrAnd: (isOr) {
            print(isOr);
          },
          onSelectedWeekDays: (newSelectedList) {
            print(newSelectedList);
          },
        );
      case 3:
        return ENewTaskNormalMonthly();
      case 4:
        return const SizedBox.shrink();
      default:
        return const SizedBox(height: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: newTaskBodySedePadding - 5,
      ),
      child: Column(
        children: [
          ENewTaskNormalPresetButtons(type: type, onChange: onChangeType),
          SizedBox(height: 20),
          showTypeElements(),
        ],
      ),
    );
  }
}
